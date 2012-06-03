package atkinslib.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Button extends Entity 
	{
		private static const STATE_DEFAULT:int = 0;
		private static const STATE_HOVER:int = 1;
		private static const STATE_CLICK:int = 2;
		
		private var state:int;
		private var image:Image;
		
		public function Button() 
		{
			state = STATE_DEFAULT;
			
			graphic = image = Image.createRect(100, 20);
			setHitbox(100, 20);
		}
		
		override public function update():void 
		{
			super.update();
			
			// Button has 3 states: default, hover and click.
			var oldState:int = state;
			if ( collidePoint(x, y, Input.mouseX, Input.mouseY) ) {
				
				if ( Input.mouseDown ) {
					state = STATE_CLICK;
				} else {
					state = STATE_HOVER;
				}
				
			} else {
				state = STATE_DEFAULT;
			}
			
			// Update the image if the state changed
			if (state != oldState) {
				stateChanged();
			}
			
			if (Input.mouseReleased) {
				click();
			}
		}
		
		/**
		 * Called when the state changes. Override to customise.
		 */
		protected function stateChanged():void {
			if (state == STATE_DEFAULT) {
					image.color = 0xffffff;
				} else if (state == STATE_HOVER) {
					image.color = 0xffff00;
				} else if (state == STATE_CLICK) {
					image.color = 0xff0000;
				}
		}
		
		/**
		 * Called when the button has been clicked. Override this!
		 */
		protected function click() void {
			
		}
		
	}

}