package  
{
	import atkinslib.PauseScreen;
	import atkinslib.ScreenEffects;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.ParticleType;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Screen;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import atkinslib.Random;
	import net.flashpunk.utils.Input;
	import flash.display.BitmapData;
	import net.flashpunk.utils.Ease;
	
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
		
		private var difficultyTween:MultiVarTween;
		public var spawnDelay:int;
		public var rockDropTime:Number;
		
		private var alive:Boolean = true;
		
		public var emitter:Emitter;
		
		private var paused:Boolean;
		private var pauseScreen:PauseScreen;
		
		public function GameWorld() 
		{
			
		}
		
		override public function begin():void 
		{
			// Pause screen
			paused = false;
			pauseScreen = new PauseScreen();
			add(pauseScreen);
			
			// Screen Effects
			screenEffects = new ScreenEffects();
			add(screenEffects);
			screenEffects.fadeFromBlack();
			
			// Initial difficulty
			rockDropTime = 3;
			spawnDelay = 16;
			difficultyTween = new MultiVarTween( function():void { trace("Difficulty tween complete!"); } );
			difficultyTween.tween(
				this,
				{
					rockDropTime: 0.5,
					spawnDelay: 8
				},
				60
			);
			addTween(difficultyTween);
			
			// Player
			player = new Player();
			add(player);
			alive = true;
			
			// Score and display
			score = 0;
			scoreText = new Text("Score: 0", 0, 0, {
				size: 16,
				color: 0xffffff
			});
			// Add the score as an entity, and put it at the front.
			addGraphic(scoreText).layer = -999;
			
			// Lives and display
			lives = player.getLives();
			livesText = new Text("Lives: " + lives, 0, 0, {
				size: 16,
				color: 0xffffff,
				width: FP.width,
				align: "right"
			});
			// Add the lives as an entity, and put it at the front.
			addGraphic(livesText).layer = -999;
			
			// Particle emitter!
			emitter = new Emitter(Assets.PARTICLE_IMG, 8,8);
			addGraphic(emitter, -900);
			// Dust particles
			var dustParticle:ParticleType = emitter.newType("dust", [1,2,3]);
			dustParticle.setMotion(0, 15, 0.3, 360, 10, 0.5, Ease.quadOut)
						.setAlpha(1, 1)
						.setColor(0x613624)
						.setGravity(1, 1);
			var fireParticle:ParticleType = emitter.newType("fire", [1,2,3,4]);
			fireParticle.setMotion(0, 5, 0.7, 360, 5, 0.3, Ease.cubeOut)
						.setAlpha(1, 0, Ease.cubeIn)
						.setColor(0xff9900, 0x000000, Ease.quadOut);
			//emitter.active = false;
			
			// Background image
			addGraphic(new Image(Assets.BACKGROUND_IMG), 10000);
			
			super.begin();
		}
		
		override public function update():void 
		{
			if (!paused) {
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
				
				// Add a new rock if necessary
				if ((score % spawnDelay) == 0) {
					add(new Rock( Random.getInt(0, FP.width - 16), rockDropTime ));
				}
				
				super.update();
			}
		}
		
		public function gameOver():void
		{
			alive = false;
			screenEffects.fadeToBlack(0.7, function():void {
				FP.world = new GameOverWorld(score);
			});
		}
		
		/**
		 * Emit some particles!
		 * @param	type - the particle type name
		 * @param	x - the x position to centre the particles on
		 * @param	y - the y position to centre the particles on
		 * @param	count - how many to emit
		 */
		public function emitParticles(type:String, x:int, y:int, count:uint):void
		{
			if (emitter.active) {
				for (var i:uint = 0; i < count; i++) {
					emitter.emit(type, x+4, y+4);
				}
			}
			
			trace(emitter.particleCount);
		}
		
		/**
		 * Pause the game!
		 */
		public function pause():void
		{
			if (!paused) {
				pauseScreen.visible = true;
				paused = true;
				emitter.active = false;
			}
		}
		
		/**
		 * Unpause the game.
		 */
		public function unpause():void
		{
			if (paused) {
				paused = false;
				pauseScreen.visible = false;
				emitter.active = true;
			}
		}
		
		override public function focusLost():void 
		{
			pause();
			super.focusLost();
		}
		override public function focusGained():void 
		{
			unpause();
			super.focusGained();
		}
		
		public function shake():void
		{
			screenEffects.shake(0.7);
		}
	}

}