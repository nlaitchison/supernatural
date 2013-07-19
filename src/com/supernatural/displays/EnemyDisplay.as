package com.supernatural.displays
{
	import com.supernatural.entity.EnemySprite;
	
	import org.flixel.FlxSprite;
	
	public class EnemyDisplay extends FlxSprite
	{
		public function EnemyDisplay(enemy:EnemySprite, X:Number=0, Y:Number=0)
		{
			super(X, Y);
			trace(enemy.type);
			if(enemy.type == "ghost")
				loadGraphic(Resource.GHOST_BG, false, false, 102, 32);
			solid = false;
		}
	}
}