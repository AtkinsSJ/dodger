package atkinslib 
{
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class MusicManager 
	{
		[Embed(source = "../../assets/Breakdown.mp3")] private static const BREAKDOWN_MP3:Class;
		[Embed(source = "../../assets/Riptide2.mp3")] private static const RIPTIDE_MP3:Class;
		private var breakdown:Sfx;
		private var riptide:Sfx;
		
		private var enabled:Boolean = true;
		private var currentTrack:Sfx = null;
		
		public function MusicManager() 
		{
			riptide = new Sfx(RIPTIDE_MP3);
			breakdown = new Sfx(BREAKDOWN_MP3);
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
		
	}

}