package  
{
	import atkinslib.ScreenEffects;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Screen;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import atkinslib.Random;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class GameWorld extends World 
	{
		private var screenEffects:ScreenEffects;
		
		private var player:Player;
		
		private var score:int;
		private var scoreText:Text;
		
		private var spawnDelay:int;
		
		private var alive:Boolean = true;
		
		public function GameWorld() 
		{
			
		}
		
		override public function begin():void 
		{
			screenEffects = new ScreenEffects();
			add(screenEffects);
			screenEffects.layer = -1000;
			
			Rock.dropTime = 3;
			spawnDelay = 16;
			
			player = new Player();
			add(player);
			alive = true;
			
			score = 0;
			scoreText = new Text("Score: 0", 0, 0, {
				size: 16,
				color: 0xffffff
			});
			// Add the score as an entity, and put it at the front.
			addGraphic(scoreText).layer = -999;
			
			
			super.begin();
		}
		
		override public function update():void 
		{
			// Update the score, unless we've lost.
			if (alive) {
				score++;
				scoreText.text = "Score: " + score;
			}
			
			if ((score % spawnDelay) == 0) {
				add(new Rock( Random.getInt(0, FP.width - 16) ));
			}
			
			if ((spawnDelay > 1) && ((score % 200) == 0)) {
				spawnDelay--;
			}
			
			if ((Rock.dropTime > 0.5) && ((score % 100) == 0)) {
				Rock.dropTime -= 0.1;
			}
			
			super.update();
		}
		
		public function gameOver():void
		{
			alive = false;
			screenEffects.fadeToBlack(1.0, function():void {
				trace("In callback");
				FP.world = new GameOverWorld(score);
			});
		}
		
	}

}