package  
{
	import atkinslib.ScreenEffects;
	import atkinslib.ui.Button;
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class CreditsWorld extends World 
	{
		private var screenEffects:ScreenEffects;
		
		[Embed(source = "../assets/credits.txt",mimeType="application/octet-stream")]
		private const CREDITS_FILE:Class;
		
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
			
			// Text
			var creditsText:ByteArray = new CREDITS_FILE();
			addGraphic( new Text(creditsText.readUTFBytes(creditsText.length), 0, 20, 
				{
					align: "center",
					size: 8,
					color: 0xffffff,
					width: FP.width,
					wordWrap: true
				}
			));
			
			// Menu button
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