package  
{
	import atkinslib.AtkinsWorld;
	import atkinslib.Random;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.ParticleType;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class GameWorld extends AtkinsWorld
	{
		private var player:Player;
		
		private var score:int;
		private var scoreText:Text;
		
		private var lives:int;
		private var livesText:Text;
		
		private var difficultyTween:MultiVarTween;
		public var spawnDelay:int;
		public var rockDropTime:Number;
		private var homingCountdown:int;
		
		private var alive:Boolean = true;
		
		public var emitter:Emitter;
		
		public function GameWorld() 
		{
			super(true, Assets.BACKGROUND_IMG);
		}
		
		override public function begin():void 
		{
			super.begin();
			
			// Screen Effects
			screenEffects.fadeFromBlack();
			
			// Initial difficulty
			rockDropTime = 2.5;
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
			homingCountdown = 20;
			
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
			addGraphic(scoreText, UI_LAYER);
			
			// Lives and display
			lives = player.getLives();
			livesText = new Text("Lives: " + lives, 0, 0, {
				size: 16,
				color: 0xffffff,
				width: FP.width,
				align: "right"
			});
			addGraphic(livesText, UI_LAYER);
			
			// Particle emitter!
			emitter = new Emitter(Assets.PARTICLE_IMG, 8,8);
			addGraphic(emitter, PARTICLE_LAYER);
			// Dust particles
			var dustParticle:ParticleType = emitter.newType("dust", [4,3,2,1,0]);
			dustParticle.setMotion(0, 15, 0.3, 360, 10, 0.3, Ease.quadOut)
						.setAlpha(1, 1)
						.setColor(0x613624, 0x613624)
						.setGravity(0.5, 0.5);
			var fireParticle:ParticleType = emitter.newType("fire", [4,3,2]);
			fireParticle.setMotion(70, 3, 1.0, 40, 3, 0, Ease.cubeOut)
						.setAlpha(1, 0, Ease.cubeIn)
						.setColor(0xff9900, 0x000000, Ease.quadOut);
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
					if (homingCountdown == 1) {
						trace("HOMING METEOR!!!");
						(create(Rock, true) as Rock).init( Random.getInt(0, FP.width), player.x, rockDropTime );
						homingCountdown = 20;
					} else {
						(create(Rock, true) as Rock).init( Random.getInt(0, FP.width), Random.getInt(0, FP.width), rockDropTime );
						homingCountdown--;
					}
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
					emitter.emit(type, x-4, y-4);
				}
			}
			
			//trace(emitter.particleCount);
		}
		
		public function shake():void
		{
			screenEffects.shake(0.7);
		}
		
		public function playerHurt():void
		{
			screenEffects.flash(0xff0000, 0.3, 0.5);
		}
		
		public function addShadow():Entity
		{
			var shadow:Entity = addGraphic(new Image(Assets.SHADOW_IMG), 1000, 0, 216);
			
			(shadow.graphic as Image).centerOrigin();
			shadow.setHitbox(16, 8);
			shadow.centerOrigin();
			
			return shadow;
		}
		
		public function removeShadow(shadow:Entity):void
		{
			remove(shadow);
		}
		
		override public function pause():void 
		{
			super.pause();
			emitter.active = false;
		}
		
		override public function unpause():void 
		{
			super.unpause();
			emitter.active = true;
		}
	}

}