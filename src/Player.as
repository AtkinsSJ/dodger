package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Input;
	import atkinslib.Random;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Player extends Entity 
	{
		private var lives:uint;
		private var invincible:Boolean;
		private var spritemap:Spritemap;
		
		private var riderImage:Image;
		private var helmetImage:Image;
		private var bikeImage:Image;
		
		// Accelerations for death animation
		public var xAcc:Number = 0;
		public var yAcc:Number = 0;
		public var rotation:Number = 0;
		public var tip:Number = 0;
		
		public function Player() 
		{
			spritemap = new Spritemap(Assets.BIKE_IMG, 16, 32);
			spritemap.add("straight", [0, 1], 10);
			spritemap.play("straight");
			addGraphic(spritemap);
			
			riderImage = new Image(Assets.RIDER_IMG);
			riderImage.visible = false;
			addGraphic(riderImage);
			helmetImage = new Image(Assets.HELMET_IMG);
			helmetImage.visible = false;
			addGraphic(helmetImage);
			bikeImage = new Image(Assets.NORIDER_IMG);
			bikeImage.visible = false;
			bikeImage.x = 8;
			bikeImage.y = 30;
			bikeImage.originX = 8;
			bikeImage.originY = 22;
			addGraphic(bikeImage);
			
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
				riderImage.x += xAcc;
				riderImage.y += yAcc;
				riderImage.angle += rotation;
				
				helmetImage.x -= (xAcc * 2);
				helmetImage.y += (yAcc / 2);
				helmetImage.angle -= rotation;
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
			(world as GameWorld).alive = false;
			(FP.engine as Main).sound.play("scream");
			var deathTween:MultiVarTween = new MultiVarTween(function():void {
				(world as GameWorld).gameOver();
			});
			
			spritemap.visible = false; // Hide 'riding' sprite
			riderImage.visible = true; // Show the biker sprite
			helmetImage.visible = true;
			bikeImage.visible = true;
			
			addTween(deathTween);
			yAcc = -10
			xAcc = Random.getFloat(3, 5) * (Random.getBoolean() ? 1 : -1);
			rotation = Random.getFloat(3, 8) * (Random.getBoolean() ? 1 : -1);
			deathTween.tween(this, {
				yAcc: 10,
				rotation: 0
			}, 2);
			
			var tipTween:VarTween = new VarTween();
			addTween(tipTween);
			tipTween.tween(bikeImage, "angle", 90, 1, Ease.backIn);
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