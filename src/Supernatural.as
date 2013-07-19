// Nicole Aitchison
// Supernatural The Game - Beta
// http://nlaitchison.github.io/supernatural/index.html

package
{	
	import com.supernatural.states.MenuState;
	import com.supernatural.states.DeanPlayState;
	
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.flixel.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass = "Preloader")]
	
	public class Supernatural extends FlxGame
	{
		public function Supernatural()
		{
			super(320,240,MenuState,2);
			setupCopyright();
		}
		
		private function setupCopyright():void
		{
			var cm:ContextMenu = new ContextMenu();
			cm.hideBuiltInItems();
			
			var myItem:ContextMenuItem = new ContextMenuItem("Copyright ©2013 Nicole Aitchison", true);
			myItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, copyrightClick);
			cm.customItems.push(myItem);
			
			this.contextMenu = cm;
		}
		
		private function copyrightClick(event:ContextMenuEvent):void
		{
			var uRequest:URLRequest = new URLRequest("http://nlaitchison.github.io/supernatural/index.html#copyright");
			navigateToURL(uRequest, "_blank");
		}
	}
}