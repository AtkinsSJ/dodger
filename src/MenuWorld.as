package  
{
	import atkinslib.ScreenEffects;
	import atkinslib.ui.Button;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class MenuWorld extends World 
	{
		private var screenEffects:ScreenEffects;
		
		public function MenuWorld() 
		{
			
		}
		
		override public function begin():void 
		{
			screenEffects = new ScreenEffects();
			add(screenEffects);
			//screenEffects.fadeFromBlack();
			
			addGraphic( new Text("49 Games", 0, 20, 
				{
					align: "center",
					size: 24,
					color: 0xff0000,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Game 1: 'Dodger'", 0, 50, 
				{
					align: "center",
					size: 16,
					color: 0xffff00,
					width: FP.width
				}
			));
			
			//addGraphic( new Text("Press space to begin", 0, 160, 
				//{
					//align: "center",
					//size: 8,
					//color: 0xffffff,
					//width: FP.width
				//}
			//));
			
			add(new Button(120, 160, 80, "Start Game", startGame));
			
			super.begin();
		}
		
		override public function update():void 
		{
			//if (Input.pressed(Key.SPACE)) {
				//startGame();
			//}
			
			super.update();
		}
		
		private function startGame():void
		{
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new GameWorld();
			});
		}
	}

}