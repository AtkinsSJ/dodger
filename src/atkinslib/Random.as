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
		 */
		public static function randInt(min:int, max:int):int
		{
			return Math.floor(Math.random() * (1 + max - min)) + min;
		}
		
	}

}