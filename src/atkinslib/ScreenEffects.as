package atkinslib 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
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
		private const SHAKE_AMOUNT:Number = 3;
		private var shakeTween:Alarm = new Alarm(0, endShake);
		private var preShakeCameraX:Number;
		private var preShakeCameraY:Number;
		
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
				// Wobble the screen!
				var cameraX:Number = preShakeCameraX + Random.getInt( -SHAKE_AMOUNT, SHAKE_AMOUNT);
				var cameraY:Number = preShakeCameraY + Random.getInt( -SHAKE_AMOUNT, SHAKE_AMOUNT);
				FP.setCamera(cameraX, cameraY);
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
		 * Start shaking the screen
		 * @param	duration
		 */
		public function shake(duration:Number = 0.7):void
		{
			if (!shakeTween.active) {
				preShakeCameraX = FP.camera.x;
				preShakeCameraY = FP.camera.y;
			}
			shakeTween.reset(duration);
		}
		
		public function endShake():void
		{
			// Put the camera back where it was before.
			FP.setCamera(preShakeCameraX, preShakeCameraY);
		}
		
	}

}