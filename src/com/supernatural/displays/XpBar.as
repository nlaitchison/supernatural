package com.supernatural.displays
{
	import org.flixel.FlxSprite;
	
	public class XpBar extends FlxSprite
	{
		public function XpBar(width:uint, X:Number=0, Y:Number=0)
		{
			super(X, Y);
			
			loadGraphic(Resource.XP_BAR, false, false, width);
			solid = false;
		}
	}
}