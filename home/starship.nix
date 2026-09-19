{ ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      command_timeout = 500;   # never let a slow repo freeze the prompt

      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$nix_shell"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];

      # only show user/host over SSH or as root
      username = {
        show_always = false;
        format = "[$user]($style)@";
      };
      hostname = {
        ssh_only = true;
        format = "[$hostname]($style) ";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;   # inside a repo, path starts from the repo root
        style = "bold blue";
      };

      git_branch = {
        format = "[$symbol$branch]($style) ";
        style = "bold purple";
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold red";
        conflicted = "=";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        modified = "!\${count}";
        staged = "+\${count}";
        deleted = "✘\${count}";
        stashed = "$";
      };

      nix_shell = {
        format = "[$symbol$state]($style) ";
        symbol = " ";
      };

      cmd_duration = {
        min_time = 2000;   # only show commands slower than 2 s
        format = "[took $duration]($style) ";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";   # turns red after a failed command
      };
    };
  };
}
