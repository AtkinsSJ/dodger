package  
{
	import atkinslib.ScreenEffects;
	import atkinslib.ui.Button;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class CreditsWorld extends World 
	{
		private var screenEffects:ScreenEffects;
		
		public function CreditsWorld() 
		{
			
		}
		
		override public function begin():void 
		{
			screenEffects = new ScreenEffects();
			add(screenEffects);
			screenEffects.fadeFromBlack();
			
			// Background image
			addGraphic(new Image(Assets.BACKGROUND_IMG), 10000);
			
			add(new Button(120, 216, 80, "Main Menu", goToMenu));
			
			super.begin();
		}
		
		public function goToMenu():void
		{
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new MenuWorld();
			});
		}
		
	}

}