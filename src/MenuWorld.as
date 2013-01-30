package  
{
	import atkinslib.AtkinsWorld;
	import atkinslib.ui.Button;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import mochi.as3.*;
	
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
			
			addGraphic( new Text("Build: " + Version.Build, 12, 220,
				{
					size: 8,
					color: 0x666666
				}
			));
			
			add(new Button(120, 144, 80, "Start Game", startGame));
			add(new Button(120, 168, 80, "High Scores", showScores));
			add(new Button(120, 192, 80, "Credits", goToCredits));
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
		
		private function showScores():void {
			FP.engine.paused = true;
			MochiScores.showLeaderboard( {
				onDisplay: function():void { trace("SHOWING SCORES!!!!!!!!!!!"); },
				onClose: function():void { trace("CLOSING SCORES!!!!!!!!!!!"); FP.engine.paused = false; },
				onError: function():void { trace("ERROR SHOWING SCORES!!!!!!!!!!!"); },
				
				width: 500,
				height: 400
			});
		}
	}

}