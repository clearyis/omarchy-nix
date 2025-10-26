{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # Environment variables
    # https://wiki.hyprland.org/Configuring/Variables/#input
    input = lib.mkDefault {
      kb_layout = "us";
      # kb_variant =
      # kb_model =
      kb_options = "compose:caps";
      # kb_rules =

      follow_mouse = 1;

      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

      touchpad = {
        natural_scroll = false;
	clickfinger_behavior = true;
      };
    };

    # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gesture = [
        "3, horizontal, workspace"
	"4, swipe, resize"
	"3, pinchout, float, float"
	"4, pinchout, float, float"
	"3, pinchin, float, tile"
	"4, pinchin, float, tile"
	"3, swipe, mod: SUPER, move"
        ];
  };
}
