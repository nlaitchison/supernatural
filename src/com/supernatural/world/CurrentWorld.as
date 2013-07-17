package com.supernatural.world
{
	import com.supernatural.entity.EnemySprite;
	import com.supernatural.entity.PlayerSprite;
	import com.supernatural.states.PlayState;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;

	public class CurrentWorld extends FlxState
	{
		public var tilemap:WorldOneTilemap;
		public static var enemyGroup:FlxGroup;

		private var _worldVO:WorldVO;
		
		public function CurrentWorld(world:uint)
		{
			if(world == 1)
			{
				_worldVO = new WorldVO;
				_worldVO.world = 1;
				_worldVO.enemyType = "ghost";
				_worldVO.enemyLvl = 1;
				add(tilemap = new WorldOneTilemap);
			}
			
			addEnemies();
		}

		public function addEnemies():void
		{
			add(enemyGroup = new FlxGroup);
			var enemyOne:EnemySprite = new EnemySprite(_worldVO.enemyType, _worldVO.enemyLvl,36, 73);
			enemyGroup.add(enemyOne);
			var enemyTwo:EnemySprite = new EnemySprite(_worldVO.enemyType,_worldVO.enemyLvl,25, 190);
			enemyGroup.add(enemyTwo);
			var enemyThree:EnemySprite = new EnemySprite(_worldVO.enemyType,_worldVO.enemyLvl,180, 130);
			enemyGroup.add(enemyThree);
			var enemyFour:EnemySprite = new EnemySprite(_worldVO.enemyType,_worldVO.enemyLvl,230, 60);
			enemyGroup.add(enemyFour);
		}
		
		public function resetEnemies():void
		{
			remove(enemyGroup);
			addEnemies();
		}

	}
}