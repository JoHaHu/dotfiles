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
    nushell
    eza
    ripgrep
    skim
    tor-browser
    mako
    wl-clipboard
    swaylock
    swayidle
    neovim
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
      files = [];
      allowOther = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.home-manager.enable = true;

  programs = {
    zathura.enable = true;
    alacritty.enable = true;
    starship = {
      enable = true;
      settings = {
        cmd_duration.disabled = true;
      };
    };
    eza = {
      enable = true;
      enableNushellIntegration = true;
    };
    nushell = {
      enable = true;
      extraConfig = ''
      $env.config = {
        show_banner: false
      }
      '';
    };
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
      systemd.target = "sway-session.target";
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
    wrapperFeatures.gtk = true;
    systemd = {
      enable = true;
      xdgAutostart = true;
    };
    swaynag = {
      enable = true;
    };
  };

  services = {
    swayidle.enable = true;
    swayidle.systemdTarget = "sway-session.target";
  };

}
