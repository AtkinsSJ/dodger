package  
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class MenuWorld extends World 
	{
		
		public function MenuWorld() 
		{
			
		}
		
		override public function begin():void 
		{
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
			
			addGraphic( new Text("Press space to begin", 0, 160, 
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
				FP.world = new GameWorld();
			}
			
			super.update();
		}
	}

}