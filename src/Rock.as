package  
{
	import atkinslib.Random;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Rock extends Entity 
	{
		private var motionTween:LinearMotion = new LinearMotion(die);
		
		private var angleTween:NumTween = new NumTween(resetRotation);
		private var rotationTime:Number;
		private var rotateClockwise:Boolean;
		
		private var image:Image;
		
		private var shadow:Entity;
		
		public function Rock() 
		{
			// Motion
			addTween(motionTween);
			
			// Rotation
			addTween(angleTween);
			
			// Rock image
			image = Assets.getRock();
			image.centerOrigin();
			image.x = 8;
			image.y = 8;
			
			graphic = image;
			
			setHitbox(16, 16, 0, 0);
			type = "rock";
		}
		
		public function init(startX:int, endX:int, dropTime:Number):void
		{
			y = -32;
			x = startX;
			
			// Make diagonal meteors move the same speed
			var distanceRatio:Number = FP.distance(startX, 0, endX, FP.height) / FP.height;
			var normalisedDropTime:Number = dropTime * distanceRatio;
			
			// Set motion
			motionTween.setMotion(x, y, endX, FP.height, normalisedDropTime, Ease.quadIn);
			
			// Rotation
			rotationTime = Random.getFloat(1, 3);
			var startAngle:Number = Random.getAngle();
			angleTween.tween( startAngle, 360, (rotationTime * (startAngle / 360)) );
			rotateClockwise = Random.getBoolean();
		}
		
		override public function added():void 
		{
			// Shadow
			shadow = (world as GameWorld).addShadow();
			shadow.x = x;
			updateShadow();
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
			(world as GameWorld).emitParticles("fire", x, y, 3);
			
			// Shadow
			updateShadow();
			
			super.update();
		}
		
		private function updateShadow():void
		{
			shadow.x = centerX;
			
			var distance:Number = FP.distance(centerX, centerY, shadow.x, shadow.y);
			var scale:Number = 1 - (distance / FP.height);
			if (scale < 0) { scale = 0; }
			(shadow.graphic as Image).scale = scale;
			(shadow.graphic as Image).alpha = scale;
		}
		
		/**
		 * Explode into particles
		 */
		public function explode():void
		{
			// Particles!
			(world as GameWorld).emitParticles("dust", x, y, 30);
			(world as GameWorld).shake();
			
			die();
		}
		
		/**
		 * Removes the rock from the world
		 */
		public function die():void
		{
			//trace("Enemy died");
			(world as GameWorld).removeShadow(shadow);
			world.recycle(this);
		}
		
		public function resetRotation():void
		{
			angleTween.tween(0, 360, rotationTime);
		}
	}

}