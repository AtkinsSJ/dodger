package atkinslib 
{
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class MusicManager 
	{
		private var breakdown:Sfx;
		private var riptide:Sfx;
		
		private var enabled:Boolean = true;
		private var currentTrack:Sfx = null;
		
		public function MusicManager() 
		{
			riptide = new Sfx(Assets.RIPTIDE_MP3);
			breakdown = new Sfx(Assets.BREAKDOWN_MP3);
		}
		
		public function playBreakdown():void {
			currentTrack = breakdown;
			if (enabled) {
				if (breakdown.playing) {
					return;
				} else {
					riptide.stop();
					breakdown.loop();
				}
			}
		}
		
		public function playRiptide():void {
			currentTrack = riptide;
			if (enabled) {
				if (riptide.playing) {
					return;
				} else {
					breakdown.stop();
					riptide.loop();
				}
			}
		}
		
		public function enable():void {
			enabled = true;
			currentTrack.loop();
		}
		
		public function disable():void {
			enabled = false;
			currentTrack.stop();
		}
		
		/**
		 * Toggles the music
		 * @return the new music state
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