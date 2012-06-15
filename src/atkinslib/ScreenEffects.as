package atkinslib 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	import atkinslib.Random;
	
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
		private const SHAKE_AMOUNT:Number = 10;
		private var shakeTween:NumTween = new NumTween(endShake);
		private var preShakeCameraX:Number;
		private var preShakeCameraY:Number;
		
		// Flash
		private var flashTween:NumTween = new NumTween();
		private var flashBox:Image;
		
		public function ScreenEffects() 
		{
			blackBox = Image.createRect(FP.width, FP.height, 0x000000);
			blackBox.visible = false;
			
			flashBox = Image.createRect(FP.width, FP.height);
			flashBox.visible = false;
			
			graphic = new Graphiclist(blackBox, flashBox);
			
			addTween(shakeTween);
			addTween(flashTween);
			
			layer = -1000;
		}
		
		override public function update():void 
		{
			super.update();
			
			if ((fadeTween != null) && fadeTween.active) {
				blackBox.alpha = fadeTween.value;
			}
			
			if (shakeTween.active) {
				// Wobble the screen!
				var cameraX:Number = preShakeCameraX + Random.getInt( -shakeTween.value, shakeTween.value);
				var cameraY:Number = preShakeCameraY + Random.getInt( -shakeTween.value, shakeTween.value);
				FP.setCamera(cameraX, cameraY);
			}
			
			if (flashTween.active) {
				flashBox.alpha = flashTween.value;
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
		
		/**
		 * Called when fading from black is completed.
		 */
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
		
		/**
		 * Called when fading to black is completed.
		 */
		public function fadeToBlackFinished():void
		{
			if (fadeCallback != null) {
				fadeCallback();
			}
			fadeTween = null;
		}
		
		/**
		 * Start shaking the screen
		 * @param	duration
		 */
		public function shake(duration:Number = 0.7):void
		{
			if (!shakeTween.active) {
				preShakeCameraX = FP.camera.x;
				preShakeCameraY = FP.camera.y;
			}
			shakeTween.tween(SHAKE_AMOUNT, 0, duration, Ease.expoOut);
		}
		
		/**
		 * Called when the shake tween ends.
		 */
		public function endShake():void
		{
			// Put the camera back where it was before.
			FP.setCamera(preShakeCameraX, preShakeCameraY);
		}
		
		/**
		 * Fades the given colour over the screen and back out again, for the given duration.
		 * @param	colour
		 * @param	duration
		 */
		public function flash(colour:uint, duration:Number = 0.3, maxAlpha:Number = 1):void
		{
			flashBox.alpha = 0;
			flashBox.color = colour;
			flashBox.visible = true;
			
			flashTween.tween(0, maxAlpha, duration, Easing.linearBoomerang);//function(t:Number):Number { return (t <= 0.5 ? (t * 2) : ((1-t) * 2) ); } );
		}
		
	}

}