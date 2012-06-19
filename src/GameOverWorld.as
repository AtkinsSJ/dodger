package  
{
	import atkinslib.Highscore;
	import atkinslib.ScreenEffects;
	import atkinslib.ui.Button;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class GameOverWorld extends World 
	{
		private var score:int;
		private var screenEffects:ScreenEffects;
		
		public function GameOverWorld(myScore:int) 
		{
			score = myScore;
		}
		
		override public function begin():void 
		{
			screenEffects = new ScreenEffects();
			add(screenEffects);
			screenEffects.fadeFromBlack();
			
			// Background image
			addGraphic(new Image(Assets.BACKGROUND_IMG), 10000);
			
			addGraphic( new Text("GAME OVER!", 0, 40, 
				{
					align: "center",
					size: 24,
					color: 0xff0000,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Score: " + score, 0, 75, 
				{
					align: "center",
					size: 32,
					color: 0xffff00,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Previous best: " + Highscore.getScore(), 0, 120, 
				{
					align: "center",
					size: 16,
					color: 0x00ff00,
					width: FP.width
				}
			));
			
			add(new Button(120, 216, 80, "Main Menu", goToMenu));
			
			if (Highscore.setScore(score)) {
				// New high score!
				addGraphic( new Text("New high score!", 0, 150, 
					{
						align: "center",
						size: 32,
						color: 0xffff00,
						width: FP.width
					}
				));
			}
			
			super.begin();
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		private function goToMenu():void
		{
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new MenuWorld();
			});
		}
	}

}