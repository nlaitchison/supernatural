package com.supernatural.displays
{
	import com.supernatural.entity.BossSprite;
	
	import org.flixel.FlxSprite;
	
	public class BossDisplay extends FlxSprite
	{
		public function BossDisplay(enemy:BossSprite, X:Number=0, Y:Number=0)
		{
			super(X, Y);
			trace(enemy.type);
			if(enemy.type == "ghost")
				loadGraphic(Resource.GHOST_BOSS_BG, false, false, 102, 32);
		}
	}
}