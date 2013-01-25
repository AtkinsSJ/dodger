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
		
		public function Assets() 
		{
			
		}
		
		public static function getRock():Image
		{
			var id:int = Random.getInt(0, ROCK_COUNT - 1);
			var clipRect:Rectangle = new Rectangle(id * ROCK_WIDTH, 0, ROCK_WIDTH, ROCK_HEIGHT);
			return new Image(ROCK_IMG, clipRect);
		}
		
	}

}