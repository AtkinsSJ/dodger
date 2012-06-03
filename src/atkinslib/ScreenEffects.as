package atkinslib 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class ScreenEffects extends Entity 
	{
		// Fading
		private var fadeTween:NumTween;
		private var blackBox:Image;
		private var fadeCallback:Function = null;
		
		// Shake
		private var shakeTween:MultiVarTween = new MultiVarTween();
		
		public function ScreenEffects() 
		{
			graphic = blackBox = new Image(new BitmapData(FP.width, FP.height, true, 0xff000000));
			blackBox.visible = false;
			
			addTween(shakeTween);
			
			layer = -1000;
		}
		
		override public function update():void 
		{
			super.update();
			
			if ((fadeTween != null) && fadeTween.active) {
				blackBox.alpha = fadeTween.value;
			}
			
			if (shakeTween.active) {
				trace(FP.screen.x);
			}
		}
		
		/**
		 * Fade the screen in from black
		 * @param	duration
		 * @param	callback
		 */
		public function fadeFromBlack(duration:Number = 0.7, callback:Function=null):void
		{
			if (fadeTween != null) {
				// We only want to execute once at a time.
				return;
			}
			
			fadeCallback = callback;
			fadeTween = new NumTween(fadeFromBlackFinished);
			addTween(fadeTween);
			blackBox.visible = true;
			fadeTween.tween(1, 0, duration);
		}
		
		public function fadeFromBlackFinished():void
		{
			if (fadeCallback != null) {
				fadeCallback();
			}
			fadeTween = null;
			blackBox.visible = false;
		}
		
		/**
		 * Fade the screen to black
		 * @param	duration
		 * @param	callback
		 */
		public function fadeToBlack(duration:Number = 0.7, callback:Function=null):void
		{
			if (fadeTween != null) {
				// We only want to execute once at a time.
				return;
			}
			
			fadeCallback = callback;
			fadeTween = new NumTween(fadeToBlackFinished);
			addTween(fadeTween);
			blackBox.visible = true;
			fadeTween.tween(0, 1, duration);
		}
		
		public function fadeToBlackFinished():void
		{
			if (fadeCallback != null) {
				fadeCallback();
			}
			fadeTween = null;
		}
		
		/**
		 * Shake the screen
		 * TODO: Fix it!
		 * @param	duration
		 */
		public function shake(duration:Number = 0.7):void
		{
			if (shakeTween.active) {
				return;
			}
			
			trace("Shaking!");
			
			shakeTween.tween(
				{
					x: FP.screen.x,
					y: FP.screen.y
				},
				{
					x: 0,
					y: 0
				},
				duration,
				Ease.bounceInOut
			);
		}
		
	}

}