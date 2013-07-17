package com.supernatural.actions
{
	import com.supernatural.entity.EnemySprite;
	import com.supernatural.entity.PlayerSprite;
	import com.supernatural.states.PlayState;
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	public class Actions extends FlxBasic
	{
		public function Actions()
		{
		}
		
		public static function attack(player:PlayerSprite, enemy:EnemySprite):void
		{
			var playerDmg:uint = Math.random()*player.maxDmg + 1;
			var enemyDmg:uint = Math.random()*enemy.maxDmg + 1;
			enemy.hurt(playerDmg);
			if(enemy.health <= 0)
				player.xp += player.gainedXp;
			else
				player.hurt(enemyDmg);
	
			trace("enemy hp:",enemy.health," player hp:", player.health," player xp:", player.xp, "player lvl:", player.lvl);
		}
		
		public static function sitting(player:PlayerSprite):void
		{
			if(player.health < player.maxHealth)
			{
				player.health += .02;
			}
		}
	}
}