# This configuration has been dervied from the default config. I've found many of the comments helpful.
# As such, I've left a lot, and will remove them if I deem them unnecessary.
{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Split hyprland config out from main system config.
      ./hyprland.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "REDACTED"; # Define your hostname. This is redacted on github, idk if it really needs to be, but I decided I might as well.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.REDACTED = {
    isNormalUser = true;
    description = "REDACTED";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # # Enable login greeter   
  # services.greetd = {
  # 	enable = true;
  # 	settings = {
  # 	  default_session = {
  # 	    command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
  # 	    user = "greeter";
  # 	  };
  # 	};
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     helix
     lshw
     git
     atlauncher
     lua-language-server
     rust-analyzer
     lldb
     jq
     libreoffice
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Hopefully enable nvidia drivers
  hardware.graphics = {
    enable = true;
  };

  #load nvidia driver
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia= {
    # Modesetting is required for some reason.
    modesetting.enable = true;

    # Experimental power management, usually leave disabled as it can cause sleep to fail, but can be useful to set to true if
    # there are graphical issues/crashes after sleep
    powerManagement.enable = false;

    # Even more experimental power management that shuts off gpu when not in use.
    powerManagement.finegrained = false;

    # Use nvidia open source kernel module. Only set to false if gpu is of 1xxx series or older. i.e. not an RTX card.
    open = true;

    # Enable nvidia settings
    nvidiaSettings = true;
    # Enable support for dual gpu's
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    # Declare the exact driver version (or channel) below
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  

  # needed for hyperland
  security.polkit = {
    enable = true;
  };

  #enable hyprland

  # programs.hyprland= {
  #   enable = true;
  #   withUWSM = false;
  #   xwayland.enable = true;
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  # };
  # enable lock screen and idle manager for hyprland
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  #enable firefox
  programs.firefox.enable = true;

  
  
  # Enable flakes and set some vars
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    allowed-users = ["REDACTED"];
    # use Cachix for cached hyprland builds.
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  
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
  system.stateVersion = "25.11"; # Did you read the comment?

}
