package com.supernatural.world
{
	import com.supernatural.entity.BossSprite;
	import com.supernatural.entity.EnemySprite;
	import com.supernatural.entity.PlayerSprite;
	import com.supernatural.states.DeanPlayState;
	
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;

	public class CurrentWorld extends FlxState
	{
		public var tilemap:WorldOneTilemap;
		public static var enemyGroup:FlxGroup;
		public static var bossGroup:FlxGroup;
		
		private var _xPos:Array = [025, 025, 100, 256, 255, 204, 180, 025, 120, 277, 233, 140, 230, 025, 120, 277, 211, 115, 050, 040, 142, 277, 047, 230, 050, 060, 185, 277, 047, 255, 080, 207, 277, 069, 255, 100, 230, 277, 093, 160];
		private var _yPos:Array = [190, 073, 052, 028, 192, 130, 130, 100, 052, 028, 192, 126, 060, 040, 080, 056, 192, 126, 073, 025, 052, 084, 190, 088, 100, 025, 046, 112, 164, 094, 025, 046, 140, 190, 126, 025, 028, 196, 190, 130];
		private var _currentPos:uint = 0;
		private var _worldVO:WorldVO;
		
		public function CurrentWorld(world:uint)
		{
			if(world == 1)
			{
				_worldVO = new WorldVO;
				_worldVO.world = 1;
				_worldVO.enemyType = "ghost";
				_worldVO.enemyLvl = 1;
				_worldVO.bossLvl = 5;
				add(tilemap = new WorldOneTilemap);
			}
			
			add(enemyGroup = new FlxGroup);
			addEnemies(4);
		}

		public function addEnemies(num:uint):void
		{
			for(var i:int = 0; i < num; i++)
			{
				var enemy:EnemySprite = new EnemySprite(_worldVO.enemyType, _worldVO.enemyLvl, _xPos[_currentPos], _yPos[_currentPos]);
				enemyGroup.add(enemy);
				if(_currentPos == _xPos.length)
				{
					_currentPos = 0;
				}
				else
					_currentPos++;
				
			}
		}
		
		public function addBoss():void
		{
			add(bossGroup = new FlxGroup);
			var boss:BossSprite = new BossSprite(_worldVO.enemyType, _worldVO.bossLvl, 162, 72);
			bossGroup.add(boss);
		}
		
		public function resetEnemies():void
		{
			remove(enemyGroup);
			//addEnemies(4);
		}

	}
}