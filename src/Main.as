package 
{
	import atkinslib.Highscore;
	import atkinslib.MusicManager;
	import atkinslib.SoundManager;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Main extends Engine
	{
		public var music:MusicManager;
		public var sound:SoundManager;
		
		public function Main():void 
		{
			super(320, 240, 30);
			FP.screen.scale = 2;
			
			//FP.console.enable();
			FP.console.toggleKey = Key.F1;
			
			music = new MusicManager();
			sound = new SoundManager();
		}
		
		override public function init():void 
		{
			FP.world = new MenuWorld();
			Highscore.init("meteorstrike");
			
			super.init();
		}
		
		override public function update():void 
		{
			super.update();
			
		}
		
	}
	
}