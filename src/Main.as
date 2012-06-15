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
			super(320, 240, 30);
			FP.screen.scale = 2;
			
			//FP.console.enable();
			FP.console.toggleKey = 223;
			
			//Input.define("left", Key.LEFT, Key.A);
			//Input.define("right", Key.RIGHT, Key.D);
			Input.define("test", Key.SPACE);
		}
		
		override public function init():void 
		{
			FP.world = new MenuWorld();
			
			super.init();
		}
		
	}
	
}