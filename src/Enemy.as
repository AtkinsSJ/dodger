package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Enemy extends Entity 
	{
		public static var dropTime:Number = 2;
		private var motionTween:LinearMotion = new LinearMotion(die);
		
		public function Enemy(myX:int) 
		{
			y = -32;
			x = myX;
			
			addTween(motionTween);
			motionTween.setMotion(x, y, x, FP.height, Enemy.dropTime, Ease.quadIn);
			
			graphic = new Image(new BitmapData(16, 16, true, 0xffff0000));
			setHitbox(16, 16, 0, 0);
			type = "enemy";
		}
		
		override public function update():void 
		{
			//this.y += velocity;
			x = motionTween.x;
			y = motionTween.y;
			
			super.update();
		}
		
		public function die():void {
			//trace("Enemy died");
			world.remove(this);
		}
	}

}