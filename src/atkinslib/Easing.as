package atkinslib 
{
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Easing extends Ease 
	{
		
		public function Easing() 
		{
			
		}
		
		/**
		 * Linearly tweens to the upper value and back down again
		 * @param	t
		 * @return
		 */
		public static function linearBoomerang(t:Number):Number
		{
			return (t <= 0.5 ? (t * 2) : ((1-t) * 2) );
		}
	}

}