package com.supernatural.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class GameOverState extends FlxState
	{
		public function GameOverState()
		{
			super();
			
			FlxG.mouse.show(); 
			var background:FlxSprite= new FlxSprite(0, 0, Resource.GAME_OVER_BG);
			add(background);
			
			var menu:Button = new Button("menu", 200, 180, "", 102, 36, Menu);
			add(menu);
		}
		
		private function Menu():void
		{
			FlxG.switchState(new MenuState);
		}
	}
}