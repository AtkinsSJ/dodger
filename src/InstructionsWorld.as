package  
{
	import atkinslib.AtkinsWorld;
	import atkinslib.ui.Button;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class InstructionsWorld extends AtkinsWorld 
	{
		
		public function InstructionsWorld() 
		{
			super(false, Assets.BACKGROUND_IMG);
		}
		
		override public function begin():void 
		{
			super.begin();
			
			addGraphic( new Text("How to Play", 0, 20, 
				{
					align: "center",
					size: 16,
					color: 0xffffff,
					width: FP.width,
					wordWrap: true
				}
			));
			
			addGraphic( new Text("Move using the mouse, and try to survive\nthe meteor strike for as long as possible!", 0, 80, 
				{
					align: "center",
					size: 8,
					color: 0xffffff,
					width: FP.width,
					wordWrap: true
				}
			));
			
			addGraphic( new Text("You can toggle the music with M and the sound with S.", 0, 140, 
				{
					align: "center",
					size: 8,
					color: 0xffffff,
					width: FP.width,
					wordWrap: true
				}
			));
			
			add(new Button(120, 216, 80, "GO!", function():void {
				screenEffects.fadeToBlack(0.7, function():void {
					FP.world = new GameWorld();
				});
			}));
		}
	}

}