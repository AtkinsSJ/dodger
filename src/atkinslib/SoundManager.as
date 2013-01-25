package atkinslib 
{
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class SoundManager 
	{
		private var enabled:Boolean = true;
		
		private var sounds:Object = {};
		
		public function SoundManager() {
			sounds["click"] = new Sfx(Assets.CLICK_MP3);
		}
		
		public function play(soundName:String):void {
			if (enabled && sounds.hasOwnProperty(soundName)) {
				sounds[soundName].play();
			}
		}
		
		public function enable():void {
			enabled = true;
		}
		
		public function disable():void {
			enabled = false;
			
			// Stop all sounds!
			for (var s:String in sounds) {
				sounds[s].stop();
			}
		}
		
		/**
		 * Toggles the sound
		 * @return Whether sound now enabled
		 */
		public function toggle():Boolean {
			if (enabled) {
				disable();
				return false;
			} else {
				enable();
				return true;
			}
		}
		
		public function isEnabled():Boolean {
			return enabled;
		}
		
	}

}