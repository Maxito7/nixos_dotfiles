# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, inputs
, neovimUtils
, wrapNeovimUnstable
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
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
    automatic = false;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Enable networking
  networking.networkmanager.enable = true;
  #networking.wireless.iwd.enable = true;
  #networking.networkmanager.wifi.backend = "iwd";

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
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.desktopManager.cinnamon.enable = false;

  services.xserver.windowManager.qtile = {
    enable = false;
    #extraPackages = python3Packages: with python3Packages; [
    #  (qtile-extras.overridePythonAttrs (old: {
    #    disabledTestPaths = [
    #      #"test/widget/test_strava.py"
    #      #"test/widget/test_image.py"
    #    ];
    #  }))
    #  pydantic-compat
    #  stravalib
    #  pyxdg
    #  pulsectl-asyncio
    #];
  };

  services.picom.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "latam";
    #xkb.layout = "us";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";
  #console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.blueman.enable = true;
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
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
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
      "audio"
      "libvirtd"
    ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (
      final: prev: {
        /*
        wezterm = prev.wezterm.overrideAttrs (o: rec {
          src = pkgs.fetchFromGitHub {
            owner = "wez";
            repo = "wezterm";
            rev = "e3cd2e93d0ee5f3af7f3fe0af86ffad0cf8c7ea8";
            fetchSubmodules = true;
            sha256 = "sha256-sj3S1fWC6j9Q/Yc+4IpLbKC3lttUWFk65ROyCdQt+Zc=";
          };

          # creating an overlay for buildRustPackage overlay
          # https://discourse.nixos.org/t/is-it-possible-to-override-cargosha256-in-buildrustpackage/4393/3
          cargoDeps = prev.rustPlatform.importCargoLock {
            lockFile = src + "/Cargo.lock";
            allowBuiltinFetchGit = true;
          };
        });
        */
        /*
        zoom-us = prev.zoom-us.overrideAttrs (attrs: {
          nativeBuildInputs = (attrs.nativeBuildInputs or [ ]) ++ [ pkgs.bbe ];
          postFixup =
            ''
              cp $out/opt/zoom/zoom .
              bbe -e 's/\0manjaro\0/\0nixos\0\0\0/' < zoom > $out/opt/zoom/zoom
            ''
            + (attrs.postFixup or "")
            + ''
              sed -i 's|Exec=|Exec=env XDG_CURRENT_DESKTOP="gnome" |' $out/share/applications/Zoom.desktop
            '';
        });
        */
      }
    )
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    xclip
    wget
    wezterm
    starship
    kitty
    #qtile
    #picom-allusive
    #compfy
    #rofi
    rofi-wayland
    firefox
    inxi
    flameshot
    gcc
    git
    gh
    unzip
    clang-tools
    lxappearance
    tectonic
    #texlive.combined.scheme-full
    zathura
    kalker
    bottom
    gnumake
    nil
    nixpkgs-fmt
    alejandra
    onlyoffice-bin
    whitesur-cursors
    #whitesur-kde
    #whitesur-gtk-theme
    #whitesur-icon-theme

    # Rust
    rustup
    wasm-pack
    cargo-generate
    slint-lsp
    lld
    clang
    openssl
    openssl.dev
    sqlx-cli

    # Typst
    typst
    typstyle
    tinymist
    pandoc

    # Random dependencies
    fontconfig
    freetype

    pkg-config

    lua-language-server
    imagemagick
    luajit
    luajitPackages.magick
    luarocks-nix
    maturin
    zoom-us
    lutgen

    stylua
    presenterm
    slides
    texlab
    lua51Packages.lua
    gccMultiStdenv
    ruff
    #ruff-lsp
    fzf
    fd
    python3Packages.pip
    python3Packages.jedi-language-server
    python3Packages.iwlib
    python3Packages.pillow
    brightnessctl

    # Python
    python3
    uv

    # Go
    go
    gopls
    gofumpt
    gotools
    templ
    htmx-lsp
    sqlite

    # Zig
    zig
    zls

    # BEAM
    gleam
    glas
    erlang
    erlang-ls
    rebar3

    elixir
    elixir-ls

    # JetBrains
    jetbrains.idea-ultimate
    jetbrains.jdk
    #jetbrains.clion
    jetbrains.pycharm-professional
    #jetbrains.rider
    jetbrains.datagrip

    # Rust CLI tools
    zoxide
    eza
    bat
    fd
    procs
    ripgrep
    ripgrep-all
    tokei
    gitui
    iwd
    #impala
    macchina
    onefetch

    # Git TUI tools
    lazygit
    gh-dash

    sdbus-cpp

    acpi

    #cava
    krita

    # Webdev
    bun
    nodejs_20
    nodePackages_latest.pnpm
    #nodePackages_latest.volar
    nodePackages_latest.svelte-language-server
    typescript
    nodePackages_latest.typescript-language-server
    biome
    k6
    vue-language-server

    # Nix CLI tools
    nh

    # Qalculate
    qalculate-qt
    qalculate-gtk

    # Virt-Manager
    #virt-manager
    #virt-manager-qt
    libvirt

    # Spacedrive
    spacedrive

    # Audio & Video
    pamixer
    pavucontrol
    blueman
    playerctl
    obs-studio
    peek
    #termusic

    # Discord
    discord

    # Yazi
    # yazi
    poppler
    jq
    ffmpegthumbnailer
    p7zip

    # WAYLAND ONLY
    grim
    slurp
    wl-clipboard
    waybar
    #wireplumber
    swww
    hyprlock
    hyprsome

    # Docker
    docker-compose

    # Charm
    charm-freeze
    glow

    libpcap

    #floorp

    # Ruby
    #ruby
    #ruby-lsp
    #rubocop

    # Haskell
    ghc
    haskellPackages.lsp
    haskellPackages.cabal-install
    haskell-language-server
    haskellPackages.fourmolu

    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.lilex
    ibm-plex
    corefonts

    # DBs
    postgresql
    sqlite

    element-desktop
  ];

  environment.sessionVariables = {
    FLAKE = "/home/lucky/.config/nixfiles/";
    LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
    CARGO_BIN_PATH = "$HOME/.cargo/bin/:PATH";
    GEM_PATH = "$HOME/.local/share/gem/ruby/3.1.0/bin/";
  };

  # Nix experimental settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://ghostty.cachix.org"
    ];
    trusted-public-keys = [
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
  };
  programs.direnv.enable = true;

  # Fish
  programs.fish.enable = true;
  #users.users.lucky.shell = pkgs.fish;

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
      #(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      inter
    ];
  };

  # Wayland + Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.bash = {
    loginShellInit = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
          exec Hyprland &> /dev/null
      fi
    '';
  };

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  virtualisation.docker = {
    enable = true;
  };

  virtualisation.libvirtd.enable = true;
  #programs.virt-manager.enable = true;

  system.stateVersion = "23.05";

  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = [ pkgs.mesa.drivers ];

  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  #nixpkgs.config.allowUnsupportedSystem = true;

  # DB stuff
  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql84;
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql_16;
}
