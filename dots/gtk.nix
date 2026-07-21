# GTK Configuration
{ pkgs, config, ... }: {

gtk = {
	enable = true;
	colorScheme = "dark";
	iconTheme = {
		name = "Papirus-Dark";
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
