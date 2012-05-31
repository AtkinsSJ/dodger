package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Player extends Entity 
	{
		
		public function Player() 
		{
			graphic = new Image(new BitmapData(16, 16, true, 0xff00ff00));
			y = 200;
			setHitbox(16, 16, 0, 0);
			type = "player";
		}
		
		override public function update():void 
		{
			x = Input.mouseX - 8;
			
			// If we collide with an enemy, game over
			if (collide("rock", x, y)) {
				var score:int = (FP.world as GameWorld).getScore();
				FP.world = new GameOverWorld(score);
			}
			
			super.update();
		}
		
	}

}