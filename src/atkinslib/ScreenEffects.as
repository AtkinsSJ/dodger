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
			
			layer = -1000;
		}
		
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
		
		override public function update():void 
		{
			super.update();
			
			if ((fadeTween != null) && fadeTween.active) {
				blackBox.alpha = fadeTween.value;
			}
		}
		
	}

}