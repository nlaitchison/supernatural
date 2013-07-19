package com.supernatural.displays
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class PlayerDisplay extends FlxSprite
	{	
		public function PlayerDisplay(playerType:String, X:Number=0, Y:Number=0)
		{
			super(X, Y);
			if(playerType == "dean")
				loadGraphic(Resource.DEAN_BG, false, false, 102, 32);
			if(playerType == "sam")
				loadGraphic(Resource.SAM_BG, false, false, 102, 32);
			solid = false;
		}
	}
}