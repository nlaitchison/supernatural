package com.supernatural.states
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class Button extends FlxButton
	{
		private var _button:String;
		
		public var hover:Boolean;//public "is mouse hovering?" bool
		
		private var image:Class;
		private var hvr:Boolean; //simple bool for only activating hover commands once
		private var imgW:int;
		
		private var HoverFunc:Array;
		
		public function Button(button:String, X:Number=0, Y:Number=0, Label:String=null, Width:int=0, Height:int=0, onClick:Function=null,Hover:Array=null)
		{
			super(X, Y, null, onClick);
			
			_button = button;
			
			if(_button == "start")
			{
				loadGraphic(Resource.START, true, false, 102, 36);
			}
			else if(_button == "help")
			{
				loadGraphic(Resource.HELP, true, false, 102, 36);
			}
			else if(_button == "back")
			{
				loadGraphic(Resource.BACK, true, false, 102, 36);
			}
			else if(_button == "menu")
			{
				loadGraphic(Resource.MENU, true, false, 102, 36);
			}
			else if(_button == "dean")
			{
				loadGraphic(Resource.DEAN, true, false, 131, 138);
			}
			else if(_button == "sam")
			{
				loadGraphic(Resource.SAM, true, false, 142, 128);
			}

			
			this.HoverFunc = Hover;
			addAnimation("icon", [0, 1], 0, false);
			
			hvr = true;
			hover = false;
		}
		
		override public function update():void
		{
			super.update();
			
			hover = (overlapsPoint(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)));
			
			if (hvr != hover && active && visible)
			{
				if (hvr)
				{
					//not hovering
					hvr = false;
					this.frame = 0;
				}
				else
				{
					//hovering
					hvr = true;
					this.frame = 1;
					
					if (HoverFunc != null)
						HoverFunc[0](HoverFunc[1]);
				}
			}	
		}
	}
}