{
  inputs,
  config,
  pkgs,
  ...
}:

{
  home.username = "REDACTED";
  home.homeDirectory = "/home/REDACTED";

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";

  wayland.windowManager.hyprland = {
    configType = "lua";
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use NixOs :^). And Nvidia hardware :^(";
    };
  };

  home.packages = [
    pkgs.signal-desktop
    # Add nix lanugage server and nixfmt 
    pkgs.nil
    pkgs.nixfmt
    # Add a screenshot manager, This should probably end up at the system level?
    pkgs.hyprshot
  ];

  home.file.".config/hypr" = {
    source = ./config/hypr;
    recursive = true;
  };
  home.file.".config/waybar" = {
    source = ./config/waybar;
    recursive = true;
  };
}
