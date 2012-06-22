package atkinslib 
{
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
		protected const PARTICLE_LAYER:int = -900;
		protected const UI_LAYER:int = -999;
		
		// Whole-screen effects
		protected var screenEffects:ScreenEffects;
		
		// Pausing
		protected var pausable:Boolean;
		private var _paused:Boolean;
		public function get paused():Boolean { return pausable && _paused; }
		public function set paused(isPaused:Boolean):void { _paused = isPaused; }
		protected var pauseScreen:PauseScreen;
		
		// Background image
		protected var background:Stamp = null;
		
		public function AtkinsWorld(canPause:Boolean, backgroundImage:Class=null) 
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
		
		/**
		 * Pause the game!
		 */
		public function pause():void
		{
			pauseScreen.visible = true;
			paused = true;
		}
		
		/**
		 * Unpause the game.
		 */
		public function unpause():void
		{
			paused = false;
			pauseScreen.visible = false;
		}
		
		override public function focusLost():void 
		{
			super.focusLost();
			
			if (pausable && !paused) {
				pause();
			}
		}
		
		override public function focusGained():void 
		{
			super.focusGained();
			
			if (pausable && paused) {
				unpause();
			}
		}
		
	}

}