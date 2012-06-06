package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(320, 240);
			FP.screen.scale = 2;
			
			//FP.console.enable();
			FP.console.toggleKey = 223;
			
			//Input.define("left", Key.LEFT, Key.A);
			//Input.define("right", Key.RIGHT, Key.D);
			//Input.define("jump", Key.UP, Key.W);
			
			// Respond when the game loses focus.
			addEventListener(Event.ACTIVATE, onActivate);
			addEventListener(Event.DEACTIVATE, onDeactivate);
		}
		
		override public function init():void 
		{
			FP.world = new MenuWorld();
			
			super.init();
		}
		
		public function onActivate(e:Event):void
		{
			if (FP.world is GameWorld) {
				(FP.world as GameWorld).unpause();
			}
		}
		
		public function onDeactivate(e:Event):void
		{
			if (FP.world is GameWorld) {
				(FP.world as GameWorld).pause();
			}
		}
		
	}
	
}