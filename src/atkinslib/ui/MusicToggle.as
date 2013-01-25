package atkinslib.ui 
{
	import atkinslib.MusicManager;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
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
		private var spritemap:Spritemap;
		
		public function MusicToggle() 
		{
			super(0, 0, 20, 20);
			x = FP.width - width;
			music = (FP.engine as Main).music;
			graphic = spritemap = new Spritemap(Assets.MUSIC_IMG, 20, 20);
			spritemap.frame = music.isEnabled() ? 0 : 1;
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
			spritemap.frame = music.toggle() ? 0 : 1;
			
		}
		
	}

}