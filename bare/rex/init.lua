-- Rex keybindings: Option+A is the prefix (Space-hold is Option on the Mac
-- via kanata), then a tmux-style key. Tabs keep Rex's own Cmd+1..9.
-- Rex reads this file on start; `rex config reload` applies edits.

local prefix = "alt+a"

-- prefix+1..9 picks a session; Rex's session.select wants an id, so pick
-- the Nth session in the order `rex ls` lists them
rex.action({
  name = "session_goto",
  title = "Go to Session N",
  run = function(ctx, args)
    local session = rex.call("session.list", {}).sessions[tonumber(args.index)]
    if session then
      rex.client.queue("session.select", { session_id = session.session_id })
    end
  end,
})

local keys = {
  -- app
  ["shift+/"] = { "client.palette.toggle" },
  ["s"] = { "client.settings" },
  -- detach: the window goes away, its sessions keep running in the server
  ["q"] = { "client.window.close" },

  -- workspaces are sessions
  ["shift+n"] = { "session.new" },
  ["shift+w"] = { "session.rename" },
  ["shift+d"] = { "session.close" },
  ["w"] = { "session.switch" },
  ["g"] = { "session.switch" },

  -- tabs
  ["c"] = { "client.tab.new" },
  ["shift+t"] = { "client.tab.rename" },
  ["shift+x"] = { "client.tab.close" },
  ["n"] = { "client.tab.next" },
  ["p"] = { "client.tab.previous" },

  -- panes
  ["h"] = { "pane.focus.left" },
  ["j"] = { "pane.focus.down" },
  ["k"] = { "pane.focus.up" },
  ["l"] = { "pane.focus.right" },
  ["shift+h"] = { "pane.move.left" },
  ["shift+j"] = { "pane.move.down" },
  ["shift+k"] = { "pane.move.up" },
  ["shift+l"] = { "pane.move.right" },
  ["v"] = { "pane.split.right" },
  ["-"] = { "pane.split.down" },
  -- the pane, or its tab when it's the last pane
  ["x"] = { "client.close" },
  ["z"] = { "pane.zoom" },

  -- layout
  ["b"] = { "client.sidebar.toggle" },
}

for n = 1, 9 do
  keys[tostring(n)] = { "session_goto", { index = n } }
end

for key, bind in pairs(keys) do
  rex.bind(prefix .. ">" .. key, bind[1], bind[2])
end

-- the prefix twice sends Option+A on to the terminal
rex.bind(prefix .. ">" .. prefix, "pane.send_key", { key = prefix })
