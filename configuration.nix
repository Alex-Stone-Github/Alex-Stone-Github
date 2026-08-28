{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos-workstation"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Timezones and Locales
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Desktop Environment
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  programs.dconf.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]);


  # Enable CUPS Printing
  services.printing.enable = true;

  # Enable Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."alex" = {
    isNormalUser = true;
    description = "Alex Stone";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Firefox here for some reason?
  programs.firefox.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # Packages
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
	  stdenv.cc.cc
	  zlib
	  glib
	  libGL
	  xorg.libX11
	  xorg.libxcb
  ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
  environment.systemPackages = with pkgs; [
    # Gui Apps
    gnome-tweaks
    adwaita-icon-theme
    chromium
    freecad
    blender
    alacritty

    # Passwords
    openssl
    libsecret
    gnupg

    # Code Editing
    neovim
    emacs
    tmux
    git
    ripgrep
    htop
    fastfetch

    # Languages
    kotlin
    kotlin-native
    gradle
    maven
    jdk
    kotlin-language-server

    nodejs

    rustc
    cargo
    rust-analyzer

    uv
    pyright

    zig
    zls

    clang-tools
    pkg-config
    cmake
    gnumake
    meson
    gcc
  ];

  system.stateVersion = "26.05";
}
