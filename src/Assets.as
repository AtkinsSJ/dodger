package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import atkinslib.Random;
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Assets 
	{
		[Embed(source = "../assets/background.png")] public static const BACKGROUND_IMG:Class;
		
		[Embed(source = "../assets/rock.png")] public static const ROCK_IMG:Class;
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