{ ... }:
{
  programs.wofi.enable = true;
  programs.wofi.style = ''
    window {
      margin: 0px;
      border: 1px solid #458588;
      background-color: #1d2021;
      border-radius: 5px;
    }

    #input {
      margin: 5px;
      border: none;
      color: #ebdbb2;
      background-color: #282828;
    }

    #inner-box {
      margin: 5px;
      border: none;
      background-color: #1d2021;
    }

    #outer-box {
      margin: 5px;
      padding: 10px;
      border: none;
      background-color: #1d2021;
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #text {
      margin: 5px;
      border: none;
      color: #ebdbb2;
    }

    #entry:selected {
      background-color: #3c3836;
    }
  '';
}
