package
{
	import com.milkmangames.nativeextensions.GoViral;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import club.emotilizer.Root;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	[SWF(width="1080",height="1920", frameRate="60")]
	public class Emotilizer extends Sprite
	{
		public static const TAG:String = "Emotilizer";
		
		public static var theStage:Stage;
		
		private var starling:Starling;
		
		public static var assetMan:AssetManager;
		
		public function Emotilizer()
		{
			if(!GoViral.isSupported())
			{
				trace("**WARNING: GOVIRAL NOT SUPPORTED**");
			}
			else
			{
				GoViral.create();
			}
			
			if(this.stage)
			{
				theStage = stage;
				
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
				
				loaderInfo.addEventListener(flash.events.Event.COMPLETE, onLoaded);
			}
			
			var iOs:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			
			/* ASSET INTIIALIZATION AND SCALING */
			
			/*
			LD: 320 x 480
			SD: 540 x 960
			HD: 1080 x 1920
			UD: 1536 x 2048
			
			*/
			
			var screenX:Number = Capabilities.screenResolutionX;
			var screenY:Number = Capabilities.screenResolutionY;
			var appDir:File = File.applicationDirectory;
			
			assetMan = new AssetManager();
			assetMan.verbose = true;
			assetMan.enqueue(File.applicationDirectory.resolvePath("assets"));
			
			Starling.handleLostContext = !iOs;
			starling = new Starling(Root, stage, null, null, "auto", "auto");
			
			starling.addEventListener(starling.events.Event.ROOT_CREATED, function(e:starling.events.Event, app:Root):void
			{
				trace("**ROOT Created**");
				trace("Scale Factor: " + starling.contentScaleFactor);
				
				starling.removeEventListener(starling.events.Event.ROOT_CREATED, arguments.callee);
				
				starling.start();
				
				assetMan.loadQueue(function(ratio:Number):void 
				{
					if (ratio == 1.0)
						app.start(assetMan);
				});
			});
			
			
			
		}
		
		protected function onLoaded(event:flash.events.Event):void
		{
			this.stage.addEventListener(flash.events.Event.RESIZE, onResize);
			this.stage.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
			
			onResize(null);
			
		}
		
		private function onResize(e:flash.events.Event):void
		{
			this.starling.stage.stageWidth = this.stage.stageWidth;
			this.starling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = this.starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this.starling.viewPort = viewPort;
			}
			catch(error:Error) {}
			
		}
		
		protected function onDeactivate(event:flash.events.Event):void
		{
			this.starling.stop();
			this.stage.addEventListener(flash.events.Event.ACTIVATE, onActivate, false, 0, true);
		}
		
		protected function onActivate(event:flash.events.Event):void
		{
			this.stage.removeEventListener(flash.events.Event.ACTIVATE, onActivate);
			this.starling.start();
		}
		
	}
}