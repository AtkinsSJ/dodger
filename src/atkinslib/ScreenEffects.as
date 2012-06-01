package atkinslib 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class ScreenEffects extends Entity 
	{
		private var fadeTween:NumTween;
		private var blackBox:Image;
		private var fadeCallback:Function = null;
		
		public function ScreenEffects() 
		{
			graphic = blackBox = new Image(new BitmapData(FP.width, FP.height, true, 0xff000000));
			blackBox.visible = false;
		}
		
		public function fadeFromBlack():void
		{
			
		}
		
		public function fadeToBlack(duration:Number = 1.0, callback:Function=null):void
		{
			if (fadeTween != null) {
				// We only want to execute once at a time.
				return;
			}
			
			trace("FadeToBlack");
			fadeCallback = callback;
			fadeTween = new NumTween(fadeToBlackFinished);
			addTween(fadeTween);
			blackBox.visible = true;
			fadeTween.tween(0, 1, duration);
		}
		
		public function fadeToBlackFinished():void
		{
			trace("Callback!");
			if (fadeCallback != null) {
				trace("Callback executed!");
				fadeCallback();
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if ((fadeTween != null) && fadeTween.active) {
				blackBox.alpha = fadeTween.value;
			}
		}
		
	}

}