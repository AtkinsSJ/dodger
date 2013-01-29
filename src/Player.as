package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.utils.Input;
	import atkinslib.Random;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Player extends Entity 
	{
		[Embed(source = "../assets/bike.png")] private static const BIKE_PNG:Class;
		
		private var lives:uint;
		private var invincible:Boolean;
		private var spritemap:Spritemap;
		
		// Accelerations for death animation
		public var xAcc:Number = 0;
		public var yAcc:Number = 0;
		public var rotation:Number = 0;
		
		public function Player() 
		{
			graphic = spritemap = new Spritemap(BIKE_PNG, 16, 32);
			spritemap.add("straight", [0, 1], 10);
			spritemap.play("straight");
			y = 215;
			
			var offX:int = 8,
				offY:int = 30;
			
			setHitbox(16, 32, offX, offY);
			graphic.x = -offX;
			graphic.y = -offY;
			
			type = "player";
			
			lives = 3;
			invincible = false;
		}
		
		override public function update():void 
		{
			if (lives > 0) {
				var oldX:Number = x;
				x = Input.mouseX;
				
				// Constrain position to the screen
				if (x < halfWidth) {
					x = halfWidth;
				} else if ( (x + halfWidth) > FP.width) {
					x = FP.width - halfWidth;
				}
				
				// Rotate sprite based on distance moved
				spritemap.angle = oldX - x;
				
				// If we collide with an enemy, game over
				var rock:Rock = collide("rock", x, y) as Rock;
				if (rock) {
					loseLife();
					rock.explode();
				}
			} else {
				spritemap.x += xAcc;
				spritemap.y += yAcc;
				spritemap.angle += rotation;
			}
			
			super.update();
		}
		
		private function loseLife():void
		{
			(FP.engine as Main).sound.play("smash");
			
			collidable = false;
			invincible = true;
			
			(world as GameWorld).playerHurt();
			
			if (lives > 0) {
				lives--;
			}
			
			if (lives == 0) {
				die();
			}
		}
		
		private function die():void {
			(FP.engine as Main).sound.play("scream");
			var deathTween:MultiVarTween = new MultiVarTween(function():void {
				(world as GameWorld).gameOver();
			});
			addTween(deathTween);
			yAcc = -10
			xAcc = Random.getFloat(3, 8) * (Random.getBoolean() ? 1 : -1);
			rotation = Random.getFloat(3, 8) * (Random.getBoolean() ? 1 : -1);
			deathTween.tween(this, {
				xAcc: 0,
				yAcc: 10,
				rotation: 0
			}, 2);
		}
		
		/**
		 * The end of the 'invincible' period, (after losing a life)
		 */
		private function endInvincibiity():void
		{
			collidable = true;
			invincible = false;
		}
		
		public function getLives():uint
		{
			return lives;
		}
		
	}

}