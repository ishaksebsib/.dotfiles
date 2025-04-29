function gs --wraps='git status --short' --description 'alias gs=git status --short'
  git status --short $argv
        
end
