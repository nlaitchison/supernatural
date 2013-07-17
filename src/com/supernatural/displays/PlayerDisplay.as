package com.supernatural.displays
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class PlayerDisplay extends FlxSprite
	{	
		public function PlayerDisplay(X:Number=0, Y:Number=0)
		{
			super(X, Y);
			loadGraphic(Resource.DISPLAY_BG, false, false, 102, 32);
		}
	}
}