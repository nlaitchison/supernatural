package 
{
	public class Resource
	{
		[Embed(source = "/tiles.png")] public static const TILES:Class;
		
		[Embed(source = "/dean.png")] public static const DEAN_PLAYER:Class;
		//[Embed(source = "/test3.png")] public static const SAM_PLAYER:Class;
		[Embed(source = "/bullet.png")] public static const BULLET:Class;
		
		[Embed(source = "/display_bg.png")] public static const DISPLAY_BG:Class;
		[Embed(source = "/ghost_display.png")] public static const GHOST_BG:Class;
		[Embed(source = "/hpbar.png")] public static const HP_BAR:Class;
		[Embed(source = "/xpbar.png")] public static const XP_BAR:Class;
		
		[Embed(source = "/ghost.png")] public static const GHOST_ENEMY:Class;
		//[Embed(source = "/test3.png")] public static const GHOST_BOSS:Class;

		[Embed(source = "/menu.png")] public static const MENU_BG:Class;
		[Embed(source = "/help_state.png")] public static const HELP_BG:Class;
		[Embed(source = "/start_button.png")] public static const START:Class;
		[Embed(source = "/help_button.png")] public static const HELP:Class;
		[Embed(source = "/back_button.png")] public static const BACK:Class;
	}
}