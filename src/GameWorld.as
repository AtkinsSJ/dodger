package  
{
	import atkinslib.ScreenEffects;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Screen;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import atkinslib.Random;
	import net.flashpunk.utils.Input;
	
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
		
		private var lives:int;
		private var livesText:Text;
		
		private var spawnDelay:int;
		
		private var alive:Boolean = true;
		
		public function GameWorld() 
		{
			
		}
		
		override public function begin():void 
		{
			screenEffects = new ScreenEffects();
			add(screenEffects);
			screenEffects.fadeFromBlack();
			
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
			
			lives = player.getLives();
			livesText = new Text("Lives: " + lives, 0, 0, {
				size: 16,
				color: 0xffffff,
				width: FP.width,
				align: "right"
			});
			// Add the lives as an entity, and put it at the front.
			addGraphic(livesText).layer = -999;
			
			super.begin();
		}
		
		override public function update():void 
		{
			// Update the score, unless we've lost.
			if (alive) {
				score++;
				scoreText.text = "Score: " + score;
			}
			
			// Change lives text if lives has changed.
			if (lives != player.getLives()) {
				lives = player.getLives();
				livesText.text = "Lives: " + lives;
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
			
			// TEST
			if (Input.check("jump")) {
				screenEffects.shake();
			}
			
			super.update();
		}
		
		public function gameOver():void
		{
			alive = false;
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new GameOverWorld(score);
			});
		}
		
	}

}