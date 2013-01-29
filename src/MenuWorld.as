package  
{
	import atkinslib.AtkinsWorld;
	import atkinslib.Highscore;
	import atkinslib.ui.Button;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class MenuWorld extends AtkinsWorld 
	{
		private static var fadeIn:Boolean = false;
		
		private const WEBSITE_URL:String = "http://samatkins.co.uk";
		
		public function MenuWorld() 
		{
			super(false, Assets.MENUBACKGROUND_IMG);
		}
		
		override public function begin():void 
		{
			super.begin();
			(FP.engine as Main).music.playBreakdown();
			
			// Don't fade in the first time.
			if (fadeIn) {
				screenEffects.fadeFromBlack();
			}
			fadeIn = true;
			
			addGraphic( new Text( "High score: " + Highscore.getScore(), 0, 110,
				{
					align: "center",
					size: 16,
					color: 0x00ff00,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Build: " + Version.Build, 12, 220,
				{
					size: 8,
					color: 0x666666
				}
			));
			
			add(new Button(120, 140, 80, "Start Game", startGame));
			add(new Button(120, 178, 80, "Credits", goToCredits));
			
			add(new Button(120, 216, 80, "Visit Website", openWebsite));
		}
		
		private function startGame():void
		{
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new InstructionsWorld();
			});
		}
		
		private function openWebsite():void
		{
			navigateToURL( new URLRequest(WEBSITE_URL), "_blank" );
		}
		
		private function goToCredits():void
		{
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new CreditsWorld();
			});
		}
	}

}