package  
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class GameOverWorld extends World 
	{
		private var score:int;
		
		public function GameOverWorld(myScore:int) 
		{
			score = myScore;
		}
		
		override public function begin():void 
		{
			addGraphic( new Text("GAME OVER!", 0, 50, 
				{
					align: "center",
					size: 24,
					color: 0xffff00,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Score: " + score, 0, 100, 
				{
					align: "center",
					size: 32,
					color: 0xffff00,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Press space to return to menu", 0, 160, 
				{
					align: "center",
					size: 8,
					color: 0xffffff,
					width: FP.width
				}
			));
			
			super.begin();
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.SPACE)) {
				FP.world = new MenuWorld();
			}
			
			super.update();
		}
		
	}

}