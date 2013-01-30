package  
{
	import atkinslib.AtkinsWorld;
	import atkinslib.ui.Button;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class GameOverWorld extends AtkinsWorld 
	{
		private var _score:int;
		
		public function GameOverWorld(myScore:int) 
		{
			super(false, Assets.BACKGROUND_IMG);
			_score = myScore;
		}
		
		override public function begin():void 
		{
			super.begin();
			
			screenEffects.fadeFromBlack();
			
			addGraphic( new Text("GAME OVER!", 0, 40, 
				{
					align: "center",
					size: 24,
					color: 0xff0000,
					width: FP.width
				}
			));
			
			addGraphic( new Text("Score: " + _score, 0, 75, 
				{
					align: "center",
					size: 32,
					color: 0xffff00,
					width: FP.width
				}
			));
			
			add(new Button(120, 178, 80, "Retry", goToGame));
			add(new Button(120, 216, 80, "Main Menu", goToMenu));
			
			FP.engine.paused = true;
			MochiScores.showLeaderboard( {
				score: _score,
				onClose: function():void {
					trace("CLOSING SCORES!!!!!!!!!!!");
					FP.engine.paused = false;
				},
				onError: function():void {
					trace("ERROR SHOWING SCORES!!!!!!!!!!!");
					FP.engine.paused = false;
				},
				width: 500,
				height: 400
			} );
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		private function goToMenu():void
		{
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new MenuWorld();
			});
		}
		
		private function goToGame():void
		{
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new GameWorld();
			});
		}
	}

}