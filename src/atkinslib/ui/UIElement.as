package atkinslib.ui 
{
	import net.flashpunk.Entity;
	
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
		
		/**
		 * Override to respind to being clicked
		 */
		public function click():void
		{
			
		}
		
	}

}