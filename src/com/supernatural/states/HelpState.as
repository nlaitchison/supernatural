package com.supernatural.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class HelpState extends FlxState
	{
		public function HelpState()
		{
			super();
			
			FlxG.mouse.show(); 
			var background:FlxSprite = new FlxSprite(0, 0, Resource.HELP_BG);
			add(background);
			
			var start:Button = new Button("start", 200, 197, "", 102, 36, StartGame);
			add(start);
			var help:Button = new Button("back", 18, 197, "", 102, 36, Back);
			add(help);
		}
		
		private function StartGame():void
		{
			FlxG.switchState(new PlayState);
		}
		
		private function Back():void
		{
			FlxG.switchState(new MenuState);
		}
	}
}