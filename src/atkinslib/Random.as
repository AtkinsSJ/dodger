package atkinslib 
{
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Random 
	{
		
		public function Random() 
		{
			
		}
		
		/**
		 * Returns a random integer, from min inclusive to max inclusive.
		 * @param	min Lowest number, inclusive.
		 * @param	max Highest number, inclusive.
		 * @return 	a random integer
		 */
		public static function getInt(min:int, max:int):int
		{
			return Math.floor(Math.random() * (1 + max - min)) + min;
		}
		
		/**
		 * 
		 * @param	min Minimum value, inclusive
		 * @param	max Maximum value inclusive
		 * @return	a random floating point number between max and min, inclusive.
		 */
		public static function getFloat(min:Number, max:Number):Number
		{
			return (Math.random() * (max - min)) + min;
		}
		
		/**
		 * 
		 * @return a random angle in degrees
		 */
		public static function getAngle():Number
		{
			return Random.getInt(0, 359);
		}
		
		/**
		 * 
		 * @return A random boolean (true or false)
		 */
		public static function getBoolean():Boolean
		{
			return Boolean(Random.getInt(0, 1));
		}
		
	}

}