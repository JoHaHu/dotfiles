{ inputs, outputs, config, pkgs, impermanence, ... }:
{
  imports = [
    impermanence.nixosModules.home-manager.impermanence
  ];

  home.username = "johannes";
  home.homeDirectory = "/home/johannes";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    vscode
    tree
    firefox
    alacritty
    nushell
    eza
    ripgrep
    tor-browser
  ];

  home.file = { };

  home.shellAliases = {
    "ll" = "ls -l";
    "ls" = "eza";
  };

  home.persistence = {
    "/persistent/home/johannes" = {
      directories = [
        "Documents"
        "Downloads"
        "code"
        ".cache/mozilla/firefox"
        ".gnupg"
        ".ssh"
        ".mozilla"
      ];
      files = [
        ".zsh_history"
      ];
      allowOther = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.home-manager.enable = true;

  programs = {
    git = {
      enable = true;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      userEmail = "mail@johupe.com";
      userName = "Johannes HUpe";
      signing = {
        key = "2B5EFAD1B03F7EEC301187D58AD559B9260504DC";
        signByDefault = true;
      };
    };

    waybar = {
      enable = true;
      systemd.enable = true;
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
      ];
    };

    zsh = {
      enable = true;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
  };

  services = {
    swayidle.enable = true;
  };

}
