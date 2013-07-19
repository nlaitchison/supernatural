package com.supernatural.states
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	public class PickCharState extends FlxState
	{
		public function PickCharState()
		{
			super();
			
			FlxG.mouse.show(); 
			var background:FlxSprite = new FlxSprite(0, 0, Resource.PICK_CHAR_BG);
			add(background);
			
			var dean:Button = new Button("dean", 10, 55, "", 131, 138, StartGameDean);
			add(dean);
			
			var sam:Button = new Button("sam", 170, 65, "", 132, 138, StartGameSam);
			add(sam);
			
			var help:Button = new Button("back", 28, 197, "", 102, 36, Back);
			add(help);
		}
		
		private function StartGameDean():void
		{
			FlxG.switchState(new DeanPlayState);
		}
		
		private function StartGameSam():void
		{
			FlxG.switchState(new SamPlayState);
		}
		
		private function Back():void
		{
			FlxG.switchState(new MenuState);
		}
	}
}