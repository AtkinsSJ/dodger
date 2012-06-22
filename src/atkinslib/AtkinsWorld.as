package atkinslib 
{
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class AtkinsWorld extends World 
	{
		// Layers
		protected const BACKGROUND_LAYER:int = 10000;
		
		// Whole-screen effects
		protected var screenEffects:ScreenEffects;
		
		// Pausing
		protected var pausable:Boolean;
		protected var paused:Boolean;
		public function get paused():Boolean { return pausable && paused; }
		public function set paused(isPaused:Boolean):void { paused = isPaused; }
		protected var pauseScreen:PauseScreen;
		
		// Background image
		protected var background:Stamp = null;
		
		public function AtkinsWorld(canPause:Boolean, backgroundImage:BitmapData=null) 
		{
			super();
			
			pausable = canPause;
			
			if (backgroundImage) {
				background = new Stamp(backgroundImage);
				addGraphic(background, BACKGROUND_LAYER);
			}
		}
		
		override public function begin():void 
		{
			super.begin();
			
			// Pause screen
			paused = false;
			if (pausable) {
				pauseScreen = new PauseScreen();
				add(pauseScreen);
			}
			
			// Screen Effects
			screenEffects = new ScreenEffects();
			add(screenEffects);
		}
		
	}

}