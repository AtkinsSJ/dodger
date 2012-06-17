package  
{
	import atkinslib.ScreenEffects;
	import atkinslib.ui.Button;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class MenuWorld extends World 
	{
		private var screenEffects:ScreenEffects;
		
		private static var fadeIn:Boolean = false;
		
		private const WEBSITE_URL:String = "http://samatkins.co.uk";
		private const GITHUB_URL:String = "https://github.com/AtkinsSJ/dodger";
		
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
			
			// Background image
			addGraphic(new Image(Assets.BACKGROUND_IMG), 10000);
			
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
			
			addGraphic( new Text("Move using the mouse, and try to survive\nthe meteor strike for as long as possible!", 0, 100, 
				{
					align: "center",
					size: 8,
					color: 0xffffff,
					width: FP.width,
					wordWrap: true
				}
			));
			
			addGraphic( new Text("Build: " + Version.Build, 12, 220,
				{
					size: 8,
					color: 0x666666
				}
			));
			
			add(new Button(120, 140, 80, "Start Game", startGame));
			
			add(new Button(120, 170, 80, "Visit Website", openWebsite));
			add(new Button(120, 200, 80, "Github Repo", openGithub));
			
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
		
		private function openWebsite():void
		{
			navigateToURL( new URLRequest(WEBSITE_URL), "_blank" );
		}
		
		private function openGithub():void
		{
			navigateToURL( new URLRequest(GITHUB_URL), "_blank" );
		}
	}

}