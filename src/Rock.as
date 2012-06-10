package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.ParticleType;
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
		//public static var dropTime:Number = 2;
		private var motionTween:LinearMotion = new LinearMotion(die);
		
		private var angleTween:NumTween = new NumTween(resetRotation);
		private var rotationTime:Number;
		private var rotateClockwise:Boolean;
		
		private var image:Image;
		private var emitter:Emitter;
		
		public function Rock(myX:int, dropTime:Number) 
		{
			y = -32;
			x = myX;
			
			// Motion
			addTween(motionTween);
			motionTween.setMotion(x, y, x, FP.height, dropTime, Ease.quadIn);
			
			// Rotation
			rotationTime = Random.getFloat(1, 3);
			addTween(angleTween);
			var startAngle:Number = Random.getAngle();
			angleTween.tween( startAngle, 360, (rotationTime * (startAngle / 360)) );
			rotateClockwise = Random.getBoolean();
			
			// Rock image
			image = Assets.getRock();
			image.centerOrigin();
			image.x = 8;
			image.y = 8;
			
			graphic = image;
			
			setHitbox(16, 16, 0, 0);
			type = "rock";
		}
		
		override public function update():void 
		{
			x = motionTween.x;
			y = motionTween.y;
			
			// Explode if we hit the ground
			if (collideRect(x, y, 0, 215, FP.width, 30)) {
				explode();
			}
			
			if (rotateClockwise) {
				image.angle = 360 - angleTween.value;
			} else {
				image.angle = angleTween.value;
			}
			
			// Fire!
			(world as GameWorld).emitParticles("fire", x, y, 4);
			
			super.update();
		}
		
		/**
		 * Explode into particles
		 */
		public function explode():void
		{
			// Particles!
			(world as GameWorld).emitParticles("dust", x, y, 50);
			(world as GameWorld).shake();
			
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