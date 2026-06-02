# GTK Configuration
{ pkgs, config, ... }: {

gtk = {
	enable = true;
	gtk4.theme = config.gtk.theme;
	colorScheme = "dark";
	theme = {
		name = "Catppuccin-GTK-Mauve-Dark";
		package = (pkgs.magnetic-catppuccin-gtk.override {
			accent = ["mauve"];
			shade = "dark";
		});
	};
	iconTheme = {
		name = "Papirus";
		package = pkgs.catppuccin-papirus-folders.override {
   			flavor = "mocha";
    			accent = "pink";
  		};
	};
	cursorTheme = {
        	name = "catppuccin-mocha-pink-cursors";
        	package = pkgs.catppuccin-cursors.mochaPink;
        	size = 24;
      	};
};

}
