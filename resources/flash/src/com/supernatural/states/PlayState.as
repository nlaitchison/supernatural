package com.supernatural.states
{
	import com.supernatural.actions.Actions;
	import com.supernatural.displays.EnemyDisplay;
	import com.supernatural.displays.HpBar;
	import com.supernatural.displays.PlayerDisplay;
	import com.supernatural.displays.XpBar;
	import com.supernatural.entity.BulletSprite;
	import com.supernatural.entity.EnemySprite;
	import com.supernatural.entity.PlayerLvlVO;
	import com.supernatural.entity.PlayerSprite;
	import com.supernatural.world.CurrentWorld;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		private var currentWorld:uint = 1;
		public var worldMap:CurrentWorld;
		
		public var player:PlayerSprite;
		public var playerDisplay:PlayerDisplay;
		public var playerHpBar:HpBar;
		public var playerXpBar:XpBar;
		private var _playerLvlTxt:FlxText;
		
		private var _enemyTouched:Boolean = false;
		private var _bullet:BulletSprite;
		private var _bulletShot:Boolean = false;
		private var _currentTarget:EnemySprite;

		public var enemyDisplay:EnemyDisplay;
		public var enemyHpBar:HpBar;
		private var _enemyDisplayVisible:Boolean = false;
		private var _enemyLvlTxt:FlxText;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff12492d;
			FlxG.mouse.show(); 
			
			add(worldMap = new CurrentWorld(currentWorld));	
			add(player = new PlayerSprite(FlxG.width/2, FlxG.height-44));
			
			createPlayerDisplay();
		}
		
		private function createPlayerDisplay():void
		{
			add(playerDisplay = new PlayerDisplay(6, 6));
			add(_playerLvlTxt = new FlxText(95,7,10, String(player.lvl)));
			_playerLvlTxt.setFormat("",8,0x222222);
			add(playerHpBar = new HpBar(55,45,21));
			add(playerXpBar = new XpBar(1,45,29));
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(worldMap, player);
			
			if(player.shoot && !_bulletShot)
			{
				if(!player.sitting)
				{
					trace("SHOOT");
					shootBullet();
				}
				else
					player.shoot = false;
			}
			
			if(_bulletShot)
			{
				for (var i:int=0; i<CurrentWorld.enemyGroup.length; i++)
					FlxG.collide(CurrentWorld.enemyGroup.members[i], _bullet, enemyHit);
				FlxG.collide(worldMap.tilemap, _bullet, destroyBullet);
			}
			
			if(player.alive)
				updateDisplay();
			else
			{
				remove(playerHpBar);
			}
			
			if(player.sitting)
			{
				Actions.sitting(player);
			}
			
			if(player.xp == player.maxXp && player.maxXp != 0)
				player.lvlUp();
			
		}
		
		private function destroyBullet(a:FlxObject, b:FlxObject):void
		{
			remove(_bullet);
			_bulletShot = false;
		}
		
		private function shootBullet():void
		{	
			_bulletShot = true;
			player.shoot = false;
			
			if(player.facing == 0x0010)
				add(_bullet = new BulletSprite(player.x+10, player.y+12));
			else if(player.facing == 0x0001)
				add(_bullet = new BulletSprite(player.x, player.y+12));
			else if(player.facing == 0x0100)
				add(_bullet = new BulletSprite(player.x+5, player.y));
			else if(player.facing == 0x1000)
				add(_bullet = new BulletSprite(player.x, player.y+12));
			
			_bullet.dir = player.facing;
		}
		
		private function enemyHit(a:FlxObject, b:FlxObject):void
		{
			_currentTarget = EnemySprite(a);
			destroyBullet(a,b);
			Actions.attack(player, _currentTarget);
			
			var hpPercent:uint = (_currentTarget.health * 100)/_currentTarget.maxHealth;
			var hpWidth:uint = (hpPercent * 55)/100;
			if(hpWidth <= 0)
				hpWidth += 1;
			
			if(!_enemyDisplayVisible)
			{
				add(enemyDisplay = new EnemyDisplay(_currentTarget, 200, 6));
				add(_enemyLvlTxt = new FlxText(289,7,10, String(_currentTarget.lvl)));
				_enemyLvlTxt.setFormat("",8,0x222222);
				add(enemyHpBar = new HpBar(hpWidth,239,29));
				_enemyDisplayVisible = true;
			}
			else if(_currentTarget.alive)
			{
				remove(enemyHpBar);
				add(enemyHpBar = new HpBar(hpWidth,239,29));
			}
			else
			{
				remove(enemyHpBar);
			}
		}
		
		private function updateDisplay():void
		{
			remove(_playerLvlTxt);
			add(_playerLvlTxt = new FlxText(95,7,10, String(player.lvl)));
			_playerLvlTxt.setFormat("",8,0x222222);
			
			var hpPercent:uint = (player.health * 100)/player.maxHealth;
			var hpWidth:uint = (hpPercent * 55)/100;
			if(hpWidth <= 0)
				hpWidth += 1;
			
			remove(playerHpBar);
			add(playerHpBar = new HpBar(hpWidth,45,21));

			var xpPercent:uint = (player.xp * 100)/player.maxXp;
			var xpWidth:uint = (xpPercent * 55)/100;
			if(xpWidth == 0)
				xpWidth += 1;	
			
			remove(playerXpBar);
			add(playerXpBar = new XpBar(xpWidth,45,29));
		}
	}
}