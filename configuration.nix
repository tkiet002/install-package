# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };
  
 
#  i18n.inputMethod = {
#   enable = true;
#   type = "ibus";
#   ibus.engines = with pkgs.ibus-engines; [

#   	anthy      # Japanese (can also use anthy or others)
      # Add more engines if needed
#    	 bamboo
#   ];
#  };
 
 i18n.inputMethod = {
     enable = true;
     type = "fcitx5";
     #waylandFrontend = true;
     fcitx5.addons = with pkgs; [
 #      fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
       kdePackages.fcitx5-qt
       #fcitx5-chinese-addons  # table input method support
 #      #fcitx5-nord            # a color theme
       fcitx5-anthy
       fcitx5-unikey
     ];
   };



  # Enable the X11 windowing system.
  services.xserver.enable = true;

  #This has to be turn off so we can switch the DE
  services.power-profiles-daemon.enable = false;
  # Enable the Deepin Desktop Environment.
#  services.xserver.displayManager.gdm.enable = true;
#  services.xserver.desktopManager.deepin.enable = true;
#  services.xserver.desktopManager.gnome.enable = true;
#  services.desktopManager.cosmic.enable = true;

  services = {
    desktopManager.plasma6.enable = true;

    displayManager.sddm.enable = true;

    displayManager.sddm.wayland.enable = true;
 };
  qt = {
   enable = true;
   platformTheme = "gnome";
   style = "adwaita-dark";
  };


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
 #Debloat Gnome
 # Remove gnome-extra packages you don't want
#  environment.gnome.excludePackages = with pkgs; [
#    gnome-maps
#    gnome-music
#    gnome-photos
#    gnome-weather
#    cheese
#    gnome-contacts
#    gnome-clocks
#    simple-scan
#    gnome-calculator
#    gnome-disk-utility
#    totem
#    yelp
#    gnome-tour
#    geary
#    gnome-calendar
#  ];



  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
  };
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
  battery = {
     governor = "powersave";
     turbo = "never";
  };
  charger = {
     governor = "performance";
     turbo = "auto";
    };
  };
  services.flatpak.enable = true;
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kp = {
    isNormalUser = true;
    description = "KP On The Way";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
#	librewolf
#	ungoogled-chromium
    ];
  };

  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     wget
     curl
     git
     helix
     tmux
     librewolf
     ungoogled-chromium
     zsh
     feh
     mpv
    nixd
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
