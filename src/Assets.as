package  
{
	import atkinslib.Random;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Assets 
	{
		[Embed(source = "../assets/background.png")]
		public static const BACKGROUND_IMG:Class;
		
		[Embed(source = "../assets/menubackground.png")]
		public static const MENUBACKGROUND_IMG:Class;
		
		[Embed(source = "../assets/particles.png")]
		public static const PARTICLE_IMG:Class;
		
		[Embed(source = "../assets/shadow.png")]
		public static const SHADOW_IMG:Class;
		
		[Embed(source = "../assets/buttons.png")]
		public static const BUTTONS_IMG:Class;
		
		[Embed(source = "../assets/music.png")]
		public static const MUSIC_IMG:Class;
		
		[Embed(source = "../assets/sound.png")]
		public static const SOUND_IMG:Class;
		
		[Embed(source = "../assets/rock.png")]
		public static const ROCK_IMG:Class;
		private static const ROCK_WIDTH:int = 16;
		private static const ROCK_HEIGHT:int = 16;
		private static const ROCK_COUNT:int = 2;
		
		[Embed(source = "../assets/bike.png")] public static const BIKE_IMG:Class;
		[Embed(source = "../assets/fling.png")] public static const RIDER_IMG:Class;
		[Embed(source = "../assets/helmet.png")] public static const HELMET_IMG:Class;
		[Embed(source = "../assets/riderless.png")] public static const NORIDER_IMG:Class;
		
		// AUDIO!
		[Embed(source = "../assets/Breakdown.mp3")] public static const BREAKDOWN_MP3:Class;
		[Embed(source = "../assets/Riptide2.mp3")] public static const RIPTIDE_MP3:Class;
		
		[Embed(source = "../assets/click.mp3")] public static const CLICK_MP3:Class;
		[Embed(source = "../assets/smash2.mp3")] public static const SMASH_MP3:Class;
		[Embed(source = "../assets/bang1.mp3")] public static const BANG1_MP3:Class;
		[Embed(source = "../assets/bang2.mp3")] public static const BANG2_MP3:Class;
		[Embed(source = "../assets/bang3.mp3")] public static const BANG3_MP3:Class;
		[Embed(source = "../assets/scream.mp3")] public static const SCREAM_MP3:Class;
		
		public static function getRock():Image
		{
			var id:int = Random.getInt(0, ROCK_COUNT - 1);
			var clipRect:Rectangle = new Rectangle(id * ROCK_WIDTH, 0, ROCK_WIDTH, ROCK_HEIGHT);
			return new Image(ROCK_IMG, clipRect);
		}
		
	}

}