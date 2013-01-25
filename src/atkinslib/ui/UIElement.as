package atkinslib.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class UIElement extends Entity 
	{
		
		public function UIElement(x:Number=0, y:Number=0, w:Number=100, h:Number=20) 
		{
			super(x, y);
			setHitbox(w, h);
		}
		
		override public function update():void 
		{
			super.update();
			
			
			if (collidePoint(x, y, world.mouseX, world.mouseY) && Input.mouseReleased) {
				click();
			}
		}
		
		/**
		 * Override to respond to being clicked
		 */
		public function click():void
		{
			
		}
		
	}

}