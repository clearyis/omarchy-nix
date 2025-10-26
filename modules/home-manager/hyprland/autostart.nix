{
  config,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "hypridle & mako & waybar & fcitx5"
      # "waybar"
      # "swaybg -i ~/.config/omarchy/current/background -m fill"
      "hyprsunset"
      "systemctl --user start hyprpolkitagent"
      "wl-clip-persist --clipboard regular & clipse -listen"
      "easyeffects"

      # "dropbox-cli start"  # Uncomment to run Dropbox
    ];

    exec = [
      "pkill -SIGUSR2 waybar || waybar"
    ];
  };
}
