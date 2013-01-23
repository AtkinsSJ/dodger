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
		
		public function MusicManager() 
		{
			riptide = new Sfx(RIPTIDE_MP3);
			breakdown = new Sfx(BREAKDOWN_MP3);
		}
		
		public function playBreakdown():void {
			if (breakdown.playing) {
				return;
			} else {
				riptide.stop();
				breakdown.loop();
			}
		}
		
		public function playRiptide():void {
			if (riptide.playing) {
				return;
			} else {
				breakdown.stop();
				riptide.loop();
			}
		}
		
	}

}