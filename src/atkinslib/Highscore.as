package atkinslib 
{
	import flash.net.SharedObject;
	/**
	 * A wrapper for maintaining a local high score.
	 * 
	 * @author Samuel Atkins
	 */
	public class Highscore 
	{
		private static var SHARED_OBJECT_NAME:String = null;
		private static var sharedObject:SharedObject = null;
		
		public function Highscore() 
		{
			
		}
		
		/**
		 * Set-up the global highscore object
		 * @param	sharedObjectName - What unique identifier to use for this game.
		 */
		public static function init( sharedObjectName:String ):void
		{
			SHARED_OBJECT_NAME = sharedObjectName;
			try {
				sharedObject = SharedObject.getLocal(SHARED_OBJECT_NAME);
			} catch (e:Error) {
				trace("Could not create shared object!\n", e.errorID, e.name, e.message);
			}
		}
		
		/**
		 * @return The current high score, or 0 if there is none
		 */
		public static function getScore():Number
		{
			return sharedObject.data.score ? sharedObject.data.score : 0;
		}
		
		/**
		 * Attempt to set the high score. This only takes place if the new score is
		 * greater than the old one.
		 * @param	score - The new score
		 * @return  Whether 'score' is the new high score 
		 */
		public static function setScore(score:Number):Boolean
		{
			var oldScore:Number = getScore();
			if (score > oldScore) {
				sharedObject.data.score = score;
				return true;
			} else {
				return false;
			}
		}
		
	}

}