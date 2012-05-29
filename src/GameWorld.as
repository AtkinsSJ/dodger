package  
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import atkinslib.Random;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class GameWorld extends World 
	{
		private var player:Player;
		
		private var score:int;
		private var scoreText:Text;
		
		private var spawnDelay:int;
		
		public function GameWorld() 
		{
			
		}
		
		override public function begin():void 
		{
			Enemy.dropTime = 3;
			spawnDelay = 16;
			
			player = new Player();
			add(player);
			
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
			// Update the score
			score++;
			scoreText.text = "Score: " + score;
			
			if ((score % spawnDelay) == 0) {
				add(new Enemy( Random.randInt(0, FP.width - 16) ));
			}
			
			if ((spawnDelay > 1) && ((score % 200) == 0)) {
				spawnDelay--;
			}
			
			if ((Enemy.dropTime > 0.5) && ((score % 100) == 0)) {
				Enemy.dropTime -= 0.1;
			}
			
			super.update();
		}
		
		public function getScore():int {
			return score;
		}
		
	}

}