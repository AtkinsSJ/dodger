package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
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
		
		public function Player() 
		{
			graphic = spritemap = new Spritemap(BIKE_PNG, 16, 16);
			spritemap.add("straight", [0]);
			spritemap.play("straight");
			y = 200;
			setHitbox(16, 16, 0, 0);
			type = "player";
			
			lives = 3;
			invincible = false;
		}
		
		override public function update():void 
		{
			x = Input.mouseX - 8;
			
			// Constrain position to the screen
			if (x < 0) {
				x = 0;
			} else if ( (x + width) > FP.width) {
				x = FP.width - width;
			}
			
			// If we collide with an enemy, game over
			var rock:Rock = collide("rock", x, y) as Rock;
			if (rock) {
				loseLife();
				rock.explode();
			}
			
			super.update();
		}
		
		private function loseLife():void
		{
			collidable = false;
			invincible = true;
			
			(world as GameWorld).playerHurt();
			
			if (lives > 0) {
				lives--;
			}
			if (lives == 0) {
				(world as GameWorld).gameOver();
			}
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