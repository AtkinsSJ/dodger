package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Player extends Entity 
	{
		private var lives:uint;
		private var invincible:Boolean;
		
		public function Player() 
		{
			graphic = new Image(new BitmapData(16, 16, true, 0xff00ff00));
			y = 200;
			setHitbox(16, 16, 0, 0);
			type = "player";
			
			lives = 3;
			invincible = false;
		}
		
		override public function update():void 
		{
			x = Input.mouseX - 8;
			
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