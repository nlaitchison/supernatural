package com.supernatural.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class MenuState extends FlxState
	{
		public function MenuState()
		{
			super();
			
			FlxG.mouse.show(); 
			var background:FlxSprite = new FlxSprite(0, 0, Resource.MENU_BG);
			add(background);
			
			var start:Button = new Button("start", 200, 155, "", 102, 36, StartGame);
			add(start);
			var help:Button = new Button("help", 200, 197, "", 102, 36, Help);
			add(help);
		}
		
		private function Help():void
		{
			FlxG.switchState(new HelpState);
		}
		
		private function StartGame():void
		{
			FlxG.switchState(new PlayState);
		}
	}
}