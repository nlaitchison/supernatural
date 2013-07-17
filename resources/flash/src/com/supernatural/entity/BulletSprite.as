package com.supernatural.entity
{
	import org.flixel.*;
	import org.flixel.FlxCamera;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxSprite;
	
	public class BulletSprite extends FlxSprite
	{	
		private var _dir:uint;
		private var _accel:int = 295;
		
		 public function BulletSprite(X:Number=0, Y:Number=0):void
		{
			super(X, Y);
			loadGraphic(Resource.BULLET, false, false, 5, 5);
			solid = true;
		}
		 
		 override public function update():void
		 {
			 if(_dir == 0x0001)
				 acceleration.x = -_accel;
			 if(_dir == 0x0010)
				 acceleration.x = _accel;
			 if(_dir == 0x0100)
				 acceleration.y = -_accel;
			 if(_dir == 0x1000)
				 acceleration.y = _accel;
			 
			 super.update();
		 }

		public function get dir():uint
		{
			return _dir;
		}

		public function set dir(value:uint):void
		{
			_dir = value;
		}

	}
}