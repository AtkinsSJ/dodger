package atkinslib.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
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
		
		protected var state:int;
		protected var image:Image;
		
		private var clickFunction:Function = null;
		
		protected var _text:Text;
		
		/**
		 * Create a new Button
		 * @param	myX
		 * @param	myY
		 * @param	onClick - Function to run when the buttin is clicked.
		 */
		public function Button(x:int, y:int, w:int, text:String, onClick:Function = null) 
		{
			this.x = x;
			this.y = y;
			clickFunction = onClick;
			setHitbox(w, 20);
			
			_text = new Text(text, 0, 4, {
				align: "center",
				size: 8,
				color: 0x000000,
				width: width
			});
			
			state = STATE_DEFAULT;
			image = Image.createRect(width, height);
			
			addGraphic(image);
			addGraphic(_text);
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
		 * Called when the button has been clicked.
		 */
		protected function click():void {
			if (clickFunction != null) {
				clickFunction();
			}
		}
		
	}

}