function rid --wraps='sudo modprobe -r hid_multitouch && sudo modprobe hid_multitouch' --description 'alias rid=sudo modprobe -r hid_multitouch && sudo modprobe hid_multitouch'
  sudo modprobe -r hid_multitouch && sudo modprobe hid_multitouch $argv
        
end
