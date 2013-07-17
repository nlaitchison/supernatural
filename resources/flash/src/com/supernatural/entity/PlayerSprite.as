package com.supernatural.entity
{
	import com.supernatural.states.PlayState;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.osmf.elements.F4MElement;
	import org.osmf.traits.PlayTrait;
	
	public class PlayerSprite extends FlxSprite
	{
		
		private var _lvl:uint = 1;
		private var _xp:uint = 0;
		private var _maxXp:uint;
		private var _gainedXp:uint;
		private var _maxHealth:uint;
		private var _maxDmg:uint;
		private var _dmg:uint;
		private var _hurtCounter:Number = 0;
		
		private var _shoot:Boolean = false;
		private var _attackCounter:Number = 0;
		
		private var _sitting:Boolean = false;
		
		private var _lvls:Array = [];
		
		public function PlayerSprite(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y);
			
			loadGraphic(Resource.DEAN_PLAYER, true, true, 18, 23);
			
			setLvls();
			
			maxVelocity.x = 80;
			maxVelocity.y = 80;
			drag.x = maxVelocity.x*8;
			drag.y = maxVelocity.y*8;
			
			addAnimation("walk", [1,0], 5, true);
			addAnimation("idle", [0]);
			addAnimation("walk_down", [4,5,3], 8, true);
			addAnimation("idle_down", [3]);
			addAnimation("walk_up", [7,8,6], 8, true);
			addAnimation("idle_up", [6]);
			addAnimation("sit", [2]);
			addAnimation("attack", [9,0], 4);
		}
		
		private function setLvls():void
		{
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest("docs/player_lvl.xml"));
			ul.addEventListener(Event.COMPLETE, onParse);
		}
		
		private function onParse(event:Event):void
		{
			var xmlData:XML = XML(event.currentTarget.data);
			for each(var level:XML in xmlData.level)
			{
				var lvl:PlayerLvlVO = new PlayerLvlVO();
				//lvl.lvl = level.@lvl;
				lvl.maxHp = level.@max_hp;
				lvl.maxDmg = level.@max_dmg;
				lvl.maxXp = level.@max_xp;
				lvl.gainedXp = level.@gained_xp;
				_lvls.push(lvl);
			}
			
			setStats();
		}
		
		public function setStats():void
		{	
			var currentLvl:PlayerLvlVO = _lvls[_lvl-1];
			
			_maxHealth = currentLvl.maxHp;
			_maxDmg = currentLvl.maxDmg;
			_maxXp = currentLvl.maxXp;
			_gainedXp = currentLvl.gainedXp;
			
			health = _maxHealth;
			_xp = 0;
			_dmg = Math.random()* maxDmg + 1;
		} 
		
		override public function update():void
		{	
			if(!alive)
			{
				if(finished)
					exists = false;
				else
					super.update();
				return;
			}
			
			if(_hurtCounter > 0)
			{
				_hurtCounter -= FlxG.elapsed*3;
				//play(hurt);
			}
			
			if(_attackCounter > 0)
			{
				_attackCounter -= FlxG.elapsed*3;
				//play("attack", true);
			}	
			
			if(FlxG.keys.justPressed("A") && !_sitting)
			{
				//_attackCounter = 1;
				play("attack");
				_shoot = true;
			}
			
			if(FlxG.keys.justPressed("S"))
			{
				if(!_sitting)
				{
					_sitting = true;
					play("sit");
				}
				else
					_sitting = false;
			}
			
			updateMovement();
			updateAnimations();
			
			super.update();
		}
		
		public function lvlUp():void
		{
			_lvl++;
			_xp = 0;
			health = maxHealth;
			setStats();
			trace("lvl up");
			trace("lvl:", _lvl, " maxHealth:", _maxHealth, " maxDmg:", _maxDmg);
		}
		
		override public function hurt(Damage:Number):void
		{
			_hurtCounter = 1;
			flicker(0.03);
			return super.hurt(Damage);	
		}
		
		private function updateMovement():void
		{
			acceleration.y = 0;
			acceleration.x = 0;
			
			if(FlxG.keys.LEFT)
			{
				_sitting = false;
				acceleration.y = 0;
				acceleration.x = -maxVelocity.x*4;
				facing = LEFT;
			}
			if(FlxG.keys.RIGHT)
			{
				_sitting = false;
				acceleration.y = 0;
				acceleration.x = maxVelocity.x*4;
				facing = RIGHT;
			}
			if(FlxG.keys.UP)
			{
				_sitting = false;
				acceleration.x = 0;
				acceleration.y = -maxVelocity.y*4;
				facing = UP;
			}
			if(FlxG.keys.DOWN)
			{
				_sitting = false;
				acceleration.x = 0;
				acceleration.y = maxVelocity.y*4;
				facing = DOWN;
			}
			
		}
		
		private function updateAnimations():void
		{
			if(facing == RIGHT || facing == LEFT)
			{
				if(acceleration.x != 0 || acceleration.y != 0)
				{
					play("walk");
				}
				else if(!_sitting && !_shoot)
				{
					play("idle");
				}
			}
			
			if(facing == DOWN && !_shoot)
			{
				if(acceleration.x != 0 || acceleration.y != 0)
				{
					play("walk_down");
				}
				else if(!_sitting && !_shoot)
				{
					play("idle_down");
				}
			}
			
			if(facing == UP && !_shoot)
			{
				if(acceleration.x != 0 || acceleration.y != 0)
				{
					play("walk_up");
				}
				else if(!_sitting && !_shoot )
				{
					play("idle_up");
				}
			}
		}

		public function get shoot():Boolean
		{
			return _shoot;
		}

		public function set shoot(value:Boolean):void
		{
			_shoot = value;
		}

		public function get maxDmg():uint
		{
			return _maxDmg;
		}

		public function get dmg():uint
		{
			return _dmg;
		}

		public function get xp():uint
		{
			return _xp;
		}

		public function set xp(value:uint):void
		{
			_xp = value;
		}

		public function get maxHealth():uint
		{
			return _maxHealth;
		}

		public function set maxHealth(value:uint):void
		{
			_maxHealth = value;
		}

		public function get gainedXp():uint
		{
			return _gainedXp;
		}

		public function set gainedXp(value:uint):void
		{
			_gainedXp = value;
		}

		public function get maxXp():uint
		{
			return _maxXp;
		}

		public function set maxXp(value:uint):void
		{
			_maxXp = value;
		}

		public function get lvl():uint
		{
			return _lvl;
		}

		public function set lvl(value:uint):void
		{
			_lvl = value;
		}

		public function get sitting():Boolean
		{
			return _sitting;
		}

		public function set sitting(value:Boolean):void
		{
			_sitting = value;
		}


	}
}