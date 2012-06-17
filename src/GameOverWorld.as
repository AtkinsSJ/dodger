package  
{
	import atkinslib.ScreenEffects;
	import atkinslib.ui.Button;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	
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
			
			//addGraphic( new Text("Press space to return to menu", 0, 160, 
				//{
					//align: "center",
					//size: 8,
					//color: 0xffffff,
					//width: FP.width
				//}
			//));
			
			add(new Button(120, 160, 80, "Main Menu", goToMenu));
			
			super.begin();
		}
		
		override public function update():void 
		{
			//if (Input.pressed(Key.SPACE)) {
				//goToMenu();
			//}
			
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