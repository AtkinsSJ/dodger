package atkinslib.ui 
{
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class TextBox extends UIElement 
	{
		
		public function TextBox(x:Number=0, y:Number=0, w:Number=100) 
		{
			super(x, y, w);
			
		}
		
		override public function click():void 
		{
			super.click();
			
			trace("The text box was clicked!");
		}
		
	}

}