package atkinslib.ui 
{
	import atkinslib.SoundManager;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class SoundToggle extends UIElement 
	{
		private var sound:SoundManager;
		private var spritemap:Spritemap;
		
		public function SoundToggle() 
		{
			super(0, 0, 20, 20);
			x = FP.width - (width*2);
			sound = (FP.engine as Main).sound;
			graphic = spritemap = new Spritemap(Assets.SOUND_IMG, 20, 20);
			spritemap.frame = sound.isEnabled() ? 0 : 1;
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
			if (Input.pressed(Key.S)) {
				toggle();
			}
		}
		
		private function toggle():void {
			spritemap.frame = sound.toggle() ? 0 : 1;
		}
		
	}

}