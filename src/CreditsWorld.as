package  
{
	import atkinslib.AtkinsWorld;
	import atkinslib.ui.Button;
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class CreditsWorld extends AtkinsWorld 
	{
		[Embed(source = "../assets/credits.txt",mimeType="application/octet-stream")]
		private const CREDITS_FILE:Class;
		
		public function CreditsWorld() 
		{
			super(false, Assets.BACKGROUND_IMG);
		}
		
		override public function begin():void 
		{
			super.begin();
			
			screenEffects.fadeFromBlack();
			
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
			
		}
		
		public function goToMenu():void
		{
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new MenuWorld();
			});
		}
		
	}

}