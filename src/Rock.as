package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	import atkinslib.Random;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Rock extends Entity 
	{
		public static var dropTime:Number = 2;
		private var motionTween:LinearMotion = new LinearMotion(die);
		
		private var angleTween:NumTween = new NumTween(resetRotation);
		private var rotationTime:Number;
		private var rotateClockwise:Boolean;
		
		private var image:Image;
		
		public function Rock(myX:int) 
		{
			y = -32;
			x = myX;
			
			// Motion
			addTween(motionTween);
			motionTween.setMotion(x, y, x, FP.height, Rock.dropTime, Ease.quadIn);
			
			// Rotation
			rotationTime = Random.getFloat(1, 3);
			addTween(angleTween);
			var startAngle:Number = Random.getAngle();
			angleTween.tween( startAngle, 360, (rotationTime * (startAngle / 360)) );
			rotateClockwise = Random.getBoolean();
			
			graphic = image = Assets.getRock(); //new BitmapData(16, 16, true, 0xffff0000));
			image.centerOrigin();
			image.x = 8;
			image.y = 8;
			
			setHitbox(16, 16, 0, 0);
			type = "rock";
		}
		
		override public function update():void 
		{
			//this.y += velocity;
			x = motionTween.x;
			y = motionTween.y;
			
			//image.angle = angleTween.angle;
			//trace(angleTween.angle);
			if (rotateClockwise) {
				image.angle = 360 - angleTween.value;
			} else {
				image.angle = angleTween.value;
			}
			
			super.update();
		}
		
		/**
		 * Explode into particles
		 */
		public function explode():void
		{
			die();
		}
		
		/**
		 * Removes the rock from the world
		 */
		public function die():void
		{
			//trace("Enemy died");
			world.remove(this);
		}
		
		public function resetRotation():void
		{
			angleTween.tween(0, 360, rotationTime);
		}
	}

}