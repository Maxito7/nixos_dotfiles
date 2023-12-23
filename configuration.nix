# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, neovimUtils, wrapNeovimUnstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 4d";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Lima";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_PE.UTF-8";
    LC_IDENTIFICATION = "es_PE.UTF-8";
    LC_MEASUREMENT = "es_PE.UTF-8";
    LC_MONETARY = "es_PE.UTF-8";
    LC_NAME = "es_PE.UTF-8";
    LC_NUMERIC = "es_PE.UTF-8";
    LC_PAPER = "es_PE.UTF-8";
    LC_TELEPHONE = "es_PE.UTF-8";
    LC_TIME = "es_PE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages: with python3Packages; [
        (qtile-extras.overridePythonAttrs(old: { disabledTestPaths = [ "test/widget/test_strava.py" ]; }))
    ];
  };
  
  services.picom.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "latam";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucky = {
    isNormalUser = true;
    description = "maxjacinto";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    xclip
    wget
    pfetch-rs
    wezterm
    starship
    kitty
    qtile
    picom-allusive
    rofi
    firefox
    inxi
    flameshot
    gcc
    git
    unzip
    cargo
    rustc
    rustfmt
    clang-tools
    lxappearance
    tectonic
    texlive.combined.scheme-full
    rust-analyzer
    zathura
    kalker
    bottom
    gnumake
    nil
    onlyoffice-bin
    
    lua-language-server
    imagemagick
    luajit
    luajitPackages.magick
    luarocks-nix
    maturin
    zoom-us
    lutgen
    #jdt-language-server
    gopls
    gci
    zls
    gofumpt
    stylua
    presenterm
    texlab
    lua51Packages.lua
    gccMultiStdenv
    ruff
    ruff-lsp
    ripgrep
    fzf
    fd
		python3Packages.pip
		python3Packages.jedi-language-server
		python3Packages.iwlib
		pipx
		brightnessctl
		
		# JetBrains
		jetbrains.idea-ultimate
    jetbrains.jdk
    jetbrains.clion
		jetbrains.pycharm-professional

		zoxide
		eza
  ];


  # Nix experimental settings
  nix.settings.experimental-features = ["nix-command" "flakes"];
	
	programs.direnv.enable = true; 

  # Fish
  programs.fish.enable = true;
  users.users.lucky.shell = pkgs.fish;	

	# Zsh
	#environment.shells = [pkgs.zsh];
	#users.defaultUserShell = pkgs.zsh;
	#programs.zsh.enable = true;

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];
  };
  
	system.stateVersion = "23.05";
} 
