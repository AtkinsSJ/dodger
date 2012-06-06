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
		
		private static var fadeIn:Boolean = false;
		
		public function MenuWorld() 
		{
			
		}
		
		override public function begin():void 
		{
			screenEffects = new ScreenEffects();
			add(screenEffects);
			
			// Don't fade in the first time.
			if (fadeIn) {
				screenEffects.fadeFromBlack();
			}
			fadeIn = true;
			
			addGraphic( new Text("49 Games", 0, 20, 
				{
					align: "center",
					size: 24,
					color: 0xff0000,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Game 1: Meteor Strike", 0, 50, 
				{
					align: "center",
					size: 16,
					color: 0xffff00,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Move using the mouse, and try to survive\nthe meteor strike for as long as possible!", 0, 120, 
				{
					align: "center",
					size: 8,
					color: 0xffffff,
					width: FP.width,
					wordWrap: true
				}
			));
			
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