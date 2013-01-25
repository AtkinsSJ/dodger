package atkinslib.ui 
{
	import atkinslib.MusicManager;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class MusicToggle extends UIElement 
	{
		private var music:MusicManager;
		
		public function MusicToggle() 
		{
			super(0, 0, 20, 20);
			x = FP.width - width;
			music = (FP.engine as Main).music;
			graphic = Image.createCircle(10, 0xff0000);
			layer = -9999;
		}
		
		override public function click():void 
		{
			super.click();
			toggle();
		}
		
		override public function update():void 
		{
			super.update();
			if (Input.pressed(Key.M)) {
				toggle();
			}
		}
		
		private function toggle():void {
			music.toggle();
		}
		
	}

}