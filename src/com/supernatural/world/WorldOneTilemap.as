package com.supernatural.world
{
	import org.flixel.FlxTilemap;
	
	public class WorldOneTilemap extends FlxTilemap
	{
		public function WorldOneTilemap()
		{
			super();
			
			var lvlOne:Array = new Array(
				01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 08, 08, 08, 08, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03,
				05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 04, 04, 04, 04, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07,
				09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 04, 04, 04, 04, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11,
				01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03, 04, 04, 04, 04, 12, 13, 12, 13, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03,
				05, 06, 07, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 05, 06, 07, 04, 04, 04, 04, 16, 17, 16, 17, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 05, 06, 07,
				09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11,
				01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03,
				05, 06, 07, 04, 04, 04, 04, 12, 13, 12, 13, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 12, 13, 04, 04, 04, 05, 06, 07,
				09, 10, 11, 04, 04, 04, 04, 16, 17, 16, 17, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 16, 17, 04, 04, 04, 09, 10, 11,
				01, 02, 03, 04, 04, 04, 04, 04, 04, 12, 13, 12, 13, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03, 04, 04, 04, 04, 04, 12, 13, 04, 04, 04, 01, 02, 03,
				05, 06, 07, 04, 04, 04, 04, 04, 04, 16, 17, 16, 17, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 05, 06, 07, 04, 04, 04, 04, 04, 16, 17, 04, 04, 04, 05, 06, 07,
				09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11,
				01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 05, 06, 07, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03,
				05, 06, 07, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11, 04, 04, 04, 04, 04, 12, 13, 12, 13, 12, 13, 05, 06, 07, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 05, 06, 07,
				09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 16, 17, 16, 17, 16, 17, 09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11,
				01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03,
				05, 06, 07, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 05, 06, 07,
				09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11,
				01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03,
				05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 04, 04, 04, 12, 13, 12, 13, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 12, 13, 12, 13, 04, 04, 04, 05, 06, 07,
				09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 04, 04, 04, 16, 17, 16, 17, 04, 04, 04, 04, 04, 01, 02, 03, 01, 02, 03, 16, 17, 16, 17, 04, 04, 04, 09, 10, 11,
				01, 02, 03, 04, 04, 04, 04, 04, 04, 01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 05, 06, 07, 05, 06, 07, 12, 13, 12, 13, 04, 04, 04, 01, 02, 03,
				05, 06, 07, 04, 04, 04, 04, 04, 04, 05, 06, 07, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11, 09, 10, 11, 16, 17, 16, 17, 04, 04, 04, 05, 06, 07,
				09, 10, 11, 04, 04, 04, 04, 04, 04, 09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11,
				01, 02, 03, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 01, 02, 03,
				05, 06, 07, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 12, 13, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 05, 06, 07,
				09, 10, 11, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 16, 17, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 04, 09, 10, 11,
				01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 04, 04, 04, 04, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03, 01, 02, 03,
				05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 04, 04, 04, 04, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07, 05, 06, 07,
				09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 08, 08, 08, 08, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11, 09, 10, 11);
			
			loadMap(FlxTilemap.arrayToCSV(lvlOne,40), Resource.TILES, 8, 8, 0, 0, 1);
			setTileProperties(4,0x000);
			
		}
	}
}