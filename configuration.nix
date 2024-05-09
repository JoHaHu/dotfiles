{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./persist.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "nuc"; # Define your hostname.

  networking.networkmanager.enable = true;


  time.timeZone = "Europe/Berlin";


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;


  users.users.johannes = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "wireshark" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqstP7+u9sbYgtf1IMyfGICccIecL3XNdKn9w0FddgN cardno:15_286_920"
    ];
    hashedPasswordFile = "/persistent/passwords/johannes";
  };
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;




  programs.fuse.userAllowOther = true; 

  environment = {
    pathsToLink = ["/share/zsh"];  
    systemPackages = with pkgs; [
      emacs
      vim
      wget
      git
      tmux
      zsh
      mako
      pipewire
    ];
  };

  services.gnome.gnome-keyring.enable = true;
  security ={
    polkit.enable = true;
    sudo.extraConfig = ''
    Defaults lecture = never
    '';
  };
  
  programs.zsh = {
    enable = true; 
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  programs.sway.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?

}

