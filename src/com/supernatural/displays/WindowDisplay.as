package com.supernatural.displays
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class WindowDisplay extends FlxSprite
	{
		public function WindowDisplay(displayType:String, X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			if(displayType == "options")
				loadGraphic(Resource.OPTIONS, false, false, 93, 79);
			
			if(displayType == "next level")
				loadGraphic(Resource.NEXT_LEVEL, false, false, 140, 90);
		}
	}
}