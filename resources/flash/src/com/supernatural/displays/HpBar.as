package com.supernatural.displays
{
	import org.flixel.FlxSprite;
	
	public class HpBar extends FlxSprite
	{
		public function HpBar(width:uint, X:Number=0, Y:Number=0)
		{
			super(X, Y);
			
			loadGraphic(Resource.HP_BAR, false, false, width);
		}
	}
}