# Noctalia V5 setup, called from flake.nix
{ inputs, ... }: {
home-manager.users.algo = {
	imports = [
      		inputs.noctalia.homeModules.default
    	];

	programs.noctalia = {
      		enable = true;
      		settings = {
        		theme = {
          			mode = "dark";
          			source = "builtin";
          			builtin = "Catppuccin";
        		};
			wallpaper = {
				enabled = true;
				directory = "~/Pictures/Wallpaper";
			};
			wallpaper.default = {
				path = "~/Pictures/Wallpaper/swan.png";
			};
			shell = {
				avatar_path = "~/Pictures/Icons/kaworu.jpg";
				time_format = "{:%-I:%M %p}";
				date_format = "{:%A}, {:%Y-%m-%d}";
			};
			shell.screenshot = {
				directory = "~/Pictures/Screenshots";
				copy_to_clipboard = true;
			};
			bar = {
				margin_ends = 0;
				padding = 10;
				radius_top_left = 0;
				radius_top_right = 0;
				shadow = false;
				start = ["control-center" "wallpaper" "notifications" "launcher"];
				center = ["workspaces"];
				end = ["clipboard" "network" "bluetooth" "volume" "brightness" "session" "battery"];
			};
			location = {
				address = "Portland, OR";
			};
		};
	};
};

}
