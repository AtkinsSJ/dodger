package atkinslib 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class PauseScreen extends Entity 
	{
		
		public function PauseScreen() 
		{
			visible = false;
			
			layer = -1000;
			
			var text:Text = new Text("Game Paused", 0, FP.halfHeight, {
				align: "center",
				size: 16,
				color: 0xffffff,
				width: FP.width
			});
			
			var background:Image = Image.createRect(FP.width, FP.height, 0, 0.5);
			
			graphic = new Graphiclist(background, text);
		}
		
	}

}