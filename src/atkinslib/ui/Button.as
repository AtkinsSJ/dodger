package atkinslib.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Button extends UIElement 
	{
		private static const STATE_DEFAULT:int = 0;
		private static const STATE_HOVER:int = 1;
		private static const STATE_CLICK:int = 2;
		
		protected var state:int;
		protected var spritemap:Spritemap;
		
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
			super(x, y, w);
			
			clickFunction = onClick;
			
			_text = new Text(text, 0, 4, {
				align: "center",
				size: 8,
				color: 0x000000,
				width: width
			});
			
			state = STATE_DEFAULT;
			spritemap = new Spritemap(Assets.BUTTONS_IMG, 80, 20);
			spritemap.frame = STATE_DEFAULT;
			
			addGraphic(spritemap);
			addGraphic(_text);
		}
		
		override public function update():void 
		{
			super.update();
			
			// Button has 3 states: default, hover and click.
			var oldState:int = state;
			if ( collidePoint(x, y, world.mouseX, world.mouseY) ) {
				
				if ( Input.mouseDown ) {
					state = STATE_CLICK;
				} else {
					state = STATE_HOVER;
				}
			
				if (Input.mouseReleased) {
					click();
				}
				
			} else {
				state = STATE_DEFAULT;
			}
			
			// Update the image if the state changed
			if (state != oldState) {
				stateChanged();
			}
		}
		
		/**
		 * Called when the state changes. Override to customise.
		 */
		protected function stateChanged():void {
			spritemap.frame = state;
		}
		
		/**
		 * Called when the button has been clicked.
		 */
		public override function click():void {
			super.click();
			
			if (clickFunction != null) {
				clickFunction();
			}
		}
		
	}

}