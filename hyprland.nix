{
  inputs,
  config,
  pkgs,
  ...
}:

{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  services.udev = {
    extraRules = ''
      KERNEL=="card*", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", KERNELS=="0000:00:02.0", SYMLINK+="dri/intel-igpu"

      KERNEL=="card*", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", KERNELS=="0000:01:00.0", SYMLINK+="dri/nvidia-dgpu"
      '';
  };
  
  environment.systemPackages = with pkgs; [
    # Install dolphin related things.
    kdePackages.qtsvg
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.dolphin
    # Install clipboard
    cliphist
    # Install other hyprland related things.
    hyprpaper
    kitty
    rofi
    waybar
    gnome-icon-theme
    mako
    lazygit
  ];

}
