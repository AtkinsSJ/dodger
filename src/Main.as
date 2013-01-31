package 
{
	import atkinslib.Highscore;
	import atkinslib.MusicManager;
	import atkinslib.SoundManager;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.system.Security;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Samuel Atkins
	 */
	public class Main extends Engine
	{
		public var music:MusicManager;
		public var sound:SoundManager;
		public var kongregate:*;
		
		public function Main():void 
		{
			super(320, 240, 30);
			FP.screen.scale = 2;
			
			//FP.console.enable();
			FP.console.toggleKey = Key.F1;
			FP.volume = 0.5;
			
			music = new MusicManager();
			sound = new SoundManager();
		}
		
		override public function init():void 
		{
			connectKongregate();
			
			FP.engine.parent.setChildIndex(FP.engine, 0);
			FP.world = new MenuWorld();
			Highscore.init("meteorbike");
			
			super.init();
		}
		
		override public function update():void 
		{
			super.update();
			
		}
		
		private function connectKongregate():void {
			// Pull the API path from the FlashVars
			var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;

			// The API path. The "shadow" API will load if testing locally. 
			var apiPath:String = paramObj.kongregate_api_path || 
			  "http://www.kongregate.com/flash/API_AS3_Local.swf";

			// Allow the API access to this SWF
			Security.allowDomain(apiPath);

			// Load the API
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void {
				// Save Kongregate API reference
				kongregate = event.target.content;

				// Connect to the back-end
				kongregate.services.connect();
				trace("WE GET KONG SIGNAL!");
			});
			loader.load(request);
			this.addChild(loader);
		}
		
	}
	
}