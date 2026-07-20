# Hjem (Home Manager Alternative) Config
# I use this to configure Hyprland in lua more easily.
# This file is called from flake.nix
{

hjem.users.algo = {
	directory = "/home/algo";
	files = {
		".config/hypr/hyprland.lua".source = ./hyprland.lua;
		# ".config/hypr/hyprpaper.lua".source = ./hyprpaper.lua; # RENABLE THIS once above is working
	};
};

hjemSettings = {
	# fuzzel.enable = true; # What is fuzzel?
	hyprland.enable = true;
	# Should Noctalia be here too?
};

}
