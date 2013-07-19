package com.supernatural.states
{
	import com.supernatural.actions.Actions;
	import com.supernatural.displays.BossDisplay;
	import com.supernatural.displays.EnemyDisplay;
	import com.supernatural.displays.HpBar;
	import com.supernatural.displays.PlayerDisplay;
	import com.supernatural.displays.WindowDisplay;
	import com.supernatural.displays.XpBar;
	import com.supernatural.entity.BossSprite;
	import com.supernatural.entity.BulletSprite;
	import com.supernatural.entity.EnemySprite;
	import com.supernatural.entity.PlayerLvlVO;
	import com.supernatural.entity.PlayerSprite;
	import com.supernatural.world.CurrentWorld;
	
	import org.flixel.*;
	
	public class SamPlayState extends FlxState
	{
		private var currentWorld:uint = 1;
		public var worldMap:CurrentWorld;
		
		public var player:PlayerSprite;
		public var playerDisplay:PlayerDisplay;
		public var playerHpBar:HpBar;
		public var playerXpBar:XpBar;
		private var _playerLvlTxt:FlxText;
		
		private var _bullet:BulletSprite;
		private var _bulletShot:Boolean = false;
		private var _enemyBullet:BulletSprite;
		private var _enemyBulletShot:Boolean = false;
		private var _bossBulletShot:Boolean = false;

		public var enemyDisplay:EnemyDisplay;
		public var enemyHpBar:HpBar;	
		private var _enemyDisplayVisible:Boolean = false;
		private var _enemyHpBarVisible:Boolean = false;
		private var _enemyLvlTxt:FlxText;
		
		public var bossDisplay:BossDisplay;
		public var bossHpBar:HpBar;	
		private var _bossDisplayVisible:Boolean = false;
		private var _bossHpBarVisible:Boolean = false;
		private var _bossLvlTxt:FlxText;
		
		private var _enemyCount:uint = 1;
		private var _bossAlive:Boolean = false;
		private var _bossKilled:Boolean = false;
		
		private var _options:WindowDisplay;
		private var _optionsVisible:Boolean;
		private var _nextLevel:WindowDisplay;
		private var _nextLevelTxt:FlxText;
		private var _nextLevelVisible:Boolean;

		private var _currentTargetEnemy:EnemySprite;
		private var _currentTargetBoss:BossSprite;
		
		override public function create():void
		{
			// sets a bg color 
			FlxG.bgColor = 0x0012492d;
			// displays mouse
			FlxG.mouse.show(); 
			
			// adds the level or world
			add(worldMap = new CurrentWorld(currentWorld));	
			// adds the player to the game
			add(player = new PlayerSprite("sam",152, 50));
			
			// calls fucntion to create player display
			createPlayerDisplay();
		}
		
		// adds players display - lvl, hp and xp bars
		private function createPlayerDisplay():void
		{
			add(playerDisplay = new PlayerDisplay("sam", 6, 6));
			add(_playerLvlTxt = new FlxText(95,7,10, String(player.lvl)));
			_playerLvlTxt.setFormat("",8,0x222222);
			add(playerHpBar = new HpBar(55,45,21));
			add(playerXpBar = new XpBar(1,45,29));
		}
		
		// update function that flixel automatically calls
		override public function update():void
		{
			super.update();
			
			// basically turns the tilemap into walls that the player cant go through
			FlxG.collide(worldMap, player);
			
			// if player shot and no bullet has been shot already then 
			if(player.shoot && !_bulletShot)
			{
				// if the player isn't sitting then shoot
				if(!player.sitting)
				{
					trace("SHOOT");
					playerShootsBullet();
				}
				// else is the player isn't sitting, don't shoot
				else
					player.shoot = false;
			}
			
			// if a bullet has been shot, find out what it hits
			if(_bulletShot)
			{	
				// check if it hits map
				FlxG.collide(worldMap.tilemap, _bullet, destroyBullet);
				// check if it hits an enemy
				for (var i:int=0; i<CurrentWorld.enemyGroup.length; i++)
					FlxG.collide(CurrentWorld.enemyGroup.members[i], _bullet, enemyHit);
				// if the boss is alive, check if it hits the boss
				if(_bossAlive)
				{
					FlxG.collide(CurrentWorld.bossGroup.members[i], _bullet, bossHit);
				}
			}
			
			if(_enemyBulletShot || _bossBulletShot)
				FlxG.collide(player, _bullet, playerHit);
			
			// if the player is alive then update it's display
			if(player.alive)
				updateDisplay();
			// if the player isn't alive then end the game
			else
			{
				remove(playerHpBar);
				FlxG.switchState(new GameOverState);
			}
			
			// if the player sits down, call function to regen hp
			if(player.sitting)
			{
				Actions.sitting(player);
			}
			
			// if an enemy has been killed, then regen another enemy
			if(_enemyCount == 0)
			{
				worldMap.addEnemies(1);
				_enemyCount = 1;
			}
			
			// if the player has reach max xp for it's level then call lvl up function 
			if(player.xp == player.maxXp && player.maxXp != 0)
				player.lvlUp();
			
			// if the user hits enter then display the options menu
			if(!_optionsVisible && player.options && !_nextLevelVisible)
			{
				add(_options = new WindowDisplay("options", 120, 80));
				_optionsVisible = true;
			}
			// if the user hits enter when the option menu us displayed, then remove the menu
			else if(_optionsVisible && !player.options && !_nextLevelVisible)
			{						
				remove(_options);
				_optionsVisible = false;
			}
			
			// if the player tries to go to next lvl, through the "portal" then 
			if(player.y >= 209 || player.y <= 8)
			{
				if(!_nextLevelVisible)
				{
					// if the boss isn't alive, display text about killing boss and add boss to game
					if(!_bossAlive && !_bossKilled)
					{
						add(_nextLevel = new WindowDisplay("next level",100,70));
						add(_nextLevelTxt = new FlxText(110,80,120,"You must defeat the boss to enter the next level."));
						_nextLevelTxt.setFormat("",8,0x222222);
						_nextLevelVisible = true;
						worldMap.addBoss();
						_bossAlive = true;
					}
					
					// if the boss is already present then just display the message to remind the player
					else if(_bossAlive && !_bossKilled)
					{
						add(_nextLevel = new WindowDisplay("next level",100,70));
						add(_nextLevelTxt = new FlxText(110,80,120,"You must defeat the boss to enter the next level."));
						_nextLevelTxt.setFormat("",8,0x222222);
						_nextLevelVisible = true;
					}
					// if the player has defeated the boss, show this message 
					else if(_bossKilled && !_bossAlive)
					{
						add(_nextLevel = new WindowDisplay("next level",100,70));
						add(_nextLevelTxt = new FlxText(110,80,120,"You defeated the Boss! But sadly, the next level is not yet available. You cannot leave Level One... "));
						_nextLevelTxt.setFormat("",8,0x222222);
						_nextLevelVisible = true;
					}
				}
			}	
			
			// if the player leaves the "portals" then remove the message
			if(player.y < 209 && player.y > 8 && _nextLevel)
			{
				remove(_nextLevel);
				remove(_nextLevelTxt);
				_nextLevelVisible = false;
			}

			// if the boss has been killed then remove the bosses display
			if(_bossKilled && !_bossAlive)
			{
				_bossDisplayVisible = false;
				remove(bossDisplay);
				remove(_bossLvlTxt);
				_bossHpBarVisible = false;
				remove(bossHpBar);
			}
			
			// if the player hits esc then end game, switch the main menu 
			if(player.endGame)
			{
				FlxG.switchState(new MenuState);
			}
		}
		
		// removes the bullet when it collides with something, remove it
		private function destroyBullet(a:FlxObject, b:FlxObject):void
		{
			remove(_bullet);
			_bulletShot = false;
			_enemyBulletShot = false;
			_bossBulletShot = false;
		}
		
		// player shoots a bullet 
		private function playerShootsBullet():void
		{	
			_bulletShot = true;
			player.shoot = false;
			
			if(player.facing == 0x0010)
				add(_bullet = new BulletSprite("player", player.x+10, player.y+12));
			else if(player.facing == 0x0001)
				add(_bullet = new BulletSprite("player", player.x, player.y+12));
			else if(player.facing == 0x0100)
				add(_bullet = new BulletSprite("player", player.x+5, player.y));
			else if(player.facing == 0x1000)
				add(_bullet = new BulletSprite("player", player.x, player.y+12));
			
			_bullet.dir = player.facing;
		}
		
		// enemy shoots a bullet
		private function enemyShootsBullet(enemy:Boolean, boss:Boolean):void
		{	
			if(enemy == true)
			{	
				_enemyBulletShot = true;
				_bossBulletShot = false;
				
				if(player.facing == 0x0010)
					add(_bullet = new BulletSprite("enemy", _currentTargetEnemy.x, _currentTargetEnemy.y+12));
				else if(player.facing == 0x0001)
					add(_bullet = new BulletSprite("enemy", _currentTargetEnemy.x+10, _currentTargetEnemy.y+12));
				else if(player.facing == 0x0100)
					add(_bullet = new BulletSprite("enemy", _currentTargetEnemy.x+5, _currentTargetEnemy.y+12));
				else if(player.facing == 0x1000)
					add(_bullet = new BulletSprite("enemy", _currentTargetEnemy.x+5, _currentTargetEnemy.y+12));
			}
			
			else if(boss == true)
			{
				_enemyBulletShot = false;
				_bossBulletShot = true;
				
				if(player.facing == 0x0010)
					add(_bullet = new BulletSprite("enemy", _currentTargetBoss.x, _currentTargetBoss.y+12));
				else if(player.facing == 0x0001)
					add(_bullet = new BulletSprite("enemy", _currentTargetBoss.x+10, _currentTargetBoss.y+12));
				else if(player.facing == 0x0100)
					add(_bullet = new BulletSprite("enemy", _currentTargetBoss.x, _currentTargetBoss.y+12));
				else if(player.facing == 0x1000)
					add(_bullet = new BulletSprite("enemy", _currentTargetBoss.x+5, _currentTargetBoss.y+12));
			}	
		
			// sets the direction of the enemies bullet opposite of the player's bullet
			if(player.facing == 0x0010)
				_bullet.dir = 0x0001;
			else if(player.facing == 0x0001)
				_bullet.dir = 0x0010;
			else if(player.facing == 0x0100)
				_bullet.dir = 0x1000;
			else if(player.facing == 0x1000)
				_bullet.dir = 0x0100;
				
		}
		
		// when the bullet hits an enemy
		private function enemyHit(a:FlxObject, b:FlxObject):void
		{
			_currentTargetEnemy = EnemySprite(a);
			destroyBullet(a,b);
			// calls the attack function to calculate dmg to hp
			Actions.attack(player, _currentTargetEnemy);
			
			// calculate size of health bar
			var hpPercent:uint = (_currentTargetEnemy.health * 100)/_currentTargetEnemy.maxHealth;
			var hpWidth:uint = (hpPercent * 55)/100;
			if(hpWidth <= 0)
				hpWidth += 1;
			
			// update enemy displays
			if(!_enemyDisplayVisible)
			{
				// if the bosses is displayed, remove it
				if(_bossDisplayVisible)
				{
					_bossDisplayVisible = false;
					remove(bossDisplay);
					remove(_bossLvlTxt);
					if(_bossHpBarVisible)
					{
						_bossHpBarVisible = false;
						remove(bossHpBar);
					}
				}
				
				add(enemyDisplay = new EnemyDisplay(_currentTargetEnemy, 200, 6));
				add(_enemyLvlTxt = new FlxText(289,7,10, String(_currentTargetEnemy.lvl)));
				_enemyLvlTxt.setFormat("",8,0x222222);
				add(enemyHpBar = new HpBar(hpWidth,239,29));
				_enemyDisplayVisible = true;
				_enemyHpBarVisible = true;
			}
			else if(_currentTargetEnemy.alive)
			{
				remove(enemyHpBar);
				add(enemyHpBar = new HpBar(hpWidth,239,29));
				_enemyHpBarVisible = true;
				// calls function for enemy to shoot back
				enemyShootsBullet(true, false);
			}
			else
			{
				remove(enemyHpBar);
				_enemyHpBarVisible = false;
				_enemyCount--;
			}
			
			
		}
		
		// when the bullet hits an enemy 
		private function bossHit(a:FlxObject, b:FlxObject):void
		{
			_currentTargetBoss = BossSprite(a);
			destroyBullet(a,b);
			// calls the attack function to calculate dmg to hp
			Actions.attackBoss(player, _currentTargetBoss);
			
			// calculates size of hp bar
			var hpPercent:uint = (_currentTargetBoss.health * 100)/_currentTargetBoss.maxHealth;
			var hpWidth:uint = (hpPercent * 55)/100;
			if(hpWidth <= 0)
				hpWidth += 1;
			
			// updates the bosses display
			if(!_bossDisplayVisible)
			{
				// if a previous enemies display is visible then remove it
				if(_enemyDisplayVisible)
				{
					_enemyDisplayVisible = false;
					remove(enemyDisplay);
					remove(_enemyLvlTxt);
					if(_enemyHpBarVisible)
					{
						_enemyHpBarVisible = false;
						remove(enemyHpBar);
					}
				}
					add(bossDisplay = new BossDisplay(_currentTargetBoss, 200, 6));
					add(_bossLvlTxt = new FlxText(289,7,10, String(_currentTargetBoss.lvl)));
					_bossLvlTxt.setFormat("",8,0x222222);
					add(bossHpBar = new HpBar(hpWidth,239,29));
					_bossDisplayVisible = true;
			}
			else if(_currentTargetBoss.alive)
			{
				remove(bossHpBar);
				add(bossHpBar = new HpBar(hpWidth,239,29));
			}
			else
			{
				remove(bossHpBar);
				_bossAlive = false;
				_bossKilled = true;
				
			}
			
			// calls function for enemy to shoot back
			enemyShootsBullet(false, true);
		}
		
		private function playerHit(a:FlxObject, b:FlxObject):void
		{
			var playerHit:PlayerSprite = PlayerSprite(a);
			
			trace(_enemyBulletShot);
			trace(_bossBulletShot);
			
			// calls the attack function to calculate dmg to hp
			if(_enemyBulletShot == true)
				Actions.enemyAttackPlayer(player, _currentTargetEnemy);
			if(_bossBulletShot == true)
				Actions.bossAttackPlayer(player, _currentTargetBoss);
			
			destroyBullet(a,b);
		}
		
		// updates the players display 
		private function updateDisplay():void
		{
			// updates the lvl display
			remove(_playerLvlTxt);
			add(_playerLvlTxt = new FlxText(95,7,10, String(player.lvl)));
			_playerLvlTxt.setFormat("",8,0x222222);
			
			// calculates size of xp bar
			var hpPercent:uint = (player.health * 100)/player.maxHealth;
			var hpWidth:uint = (hpPercent * 55)/100;
			if(hpWidth <= 0)
				hpWidth += 1;
			
			remove(playerHpBar);
			add(playerHpBar = new HpBar(hpWidth,45,21));

			// calculates size of hp bar
			var xpPercent:uint = (player.xp * 100)/player.maxXp;
			var xpWidth:uint = (xpPercent * 55)/100;
			if(xpWidth == 0)
				xpWidth += 1;	
			
			remove(playerXpBar);
			add(playerXpBar = new XpBar(xpWidth,45,29));
		}
	}
}