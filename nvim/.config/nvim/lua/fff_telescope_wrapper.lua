local M = {}

local file_picker = require("fff.file_picker")

function M.find_files()
  local telescope_ok, _ = pcall(require, 'telescope')
  if not telescope_ok then
    vim.notify('Telescope not found', vim.log.levels.ERROR)
    return
  end

  -- Initialize file picker if not already
  if not file_picker.is_initialized() then
    if not file_picker.setup() then
      vim.notify('Failed to initialize file picker', vim.log.levels.ERROR)
      return
    end
    file_picker.wait_for_initial_scan(5000)
    file_picker.scan_files() end

  local finders = require('telescope.finders')
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local pickers = require('telescope.pickers')
  local conf = require("telescope.config").values

  local function entry_maker(entry)
    local relative_path = entry.relative_path or entry.name or "unknown"
    if type(relative_path) ~= "string" then
      relative_path = tostring(relative_path)
    end

    local status_icon = ''
    if entry.git_status and entry.git_status ~= 'clean' and entry.git_status ~= '' and entry.git_status ~= 'unknown' and entry.git_status ~= 'clear' then
      local first = entry.git_status:sub(1, 1):upper()
      status_icon = first .. ' '
    end

    local file_icon = ''
    local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
    if has_devicons then
      local ext = vim.fn.fnamemodify(entry.path, ':e')
      file_icon = devicons.get_icon(entry.name, ext, { default = true }) or ''
      if file_icon ~= '' then file_icon = file_icon .. ' ' end
    end

    return {
      value = entry,
      display = status_icon .. file_icon .. relative_path,
      ordinal = relative_path,
      path = entry.path,
    }
  end

  local opts = {}
  opts.entry_maker = entry_maker

  local picker = pickers.new(opts, {
    prompt_title = 'Find Files',
    finder = finders.new_table({
      results = file_picker.search_files('', 1000, 4, nil, false),
      entry_maker = entry_maker,
    }),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
    on_input_filter_cb = function(prompt)
      local results = file_picker.search_files(prompt, 1000, 4, nil, false)
      return finders.new_table({
        results = results,
        entry_maker = entry_maker,
      })
    end,
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('edit ' .. vim.fn.fnameescape(selection.path))
      end)
      actions.select_horizontal:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('split ' .. vim.fn.fnameescape(selection.path))
      end)
      actions.select_vertical:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('vsplit ' .. vim.fn.fnameescape(selection.path))
      end)
      actions.select_tab:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd('tabedit ' .. vim.fn.fnameescape(selection.path))
      end)
      return true
    end,
  })

  picker:find()
end

return M
