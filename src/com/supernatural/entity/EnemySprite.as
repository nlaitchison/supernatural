package com.supernatural.entity
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	public class EnemySprite extends FlxSprite
	{
		private var _type:String;
		private var _maxHealth:uint;
		private var _maxDmg:uint;
		private var _hurtCounter:Number = 0;
		private var _lvl:uint;
		
		public function EnemySprite(enemyType:String, enemyLvl:uint, X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			_type = enemyType;
			_lvl = enemyLvl;
			
			if(enemyType == "ghost")
				loadGraphic(Resource.GHOST_ENEMY, true, false, 18, 25);
			
			setStats(_lvl);
			
			addAnimation("float", [0,1], 3, true);
			play("float");
			immovable = true;
			health = _maxHealth;
			//solid = true;
		}
		
		public function get lvl():uint
		{
			return _lvl;
		}

		public function set lvl(value:uint):void
		{
			_lvl = value;
		}

		public function get maxHealth():uint
		{
			return _maxHealth;
		}

		public function set maxHealth(value:uint):void
		{
			_maxHealth = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
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
		}
		
		override public function hurt(Damage:Number):void
		{
			_hurtCounter = 1;
			flicker(0.2);
			return super.hurt(Damage);	
		}
		
		private function setStats(lvl:uint):void
		{
			if(lvl == 1)
				_maxHealth  = 100;
				_maxDmg = 20;
		}

		public function get maxDmg():uint
		{
			return _maxDmg;
		}

		public function set maxDmg(value:uint):void
		{
			_maxDmg = value;
		}


	}
}