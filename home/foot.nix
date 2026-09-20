{ ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        #shell = "tmux new-session -A -s main";
        font = "JetBrainsMono Nerd Font:size=13";
      };

      mouse = {
        hide-when-typing = "no";
        alternate-scroll-mode = "no";
      };

      mouse-bindings = {
        # Unbind default quote selection to free up triple-click
        select-quote = "none";

        # Mouse selection bindings
        select-begin = "BTN_LEFT";
        select-begin-block = "Control+BTN_LEFT";
        select-word = "BTN_LEFT-2";
        select-row = "BTN_LEFT-3";
        select-extend = "BTN_RIGHT";
        primary-paste = "BTN_MIDDLE";
      };
    };
  };
}
