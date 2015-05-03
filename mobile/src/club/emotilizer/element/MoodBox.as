package club.emotilizer.element
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import club.emotilizer.Root;
	import club.emotilizer.util.CurrentFBUser;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	
	public class MoodBox extends LayoutGroup
	{
		private var moodLabel:Label;
		private var moodField:Label;
		private var moodPic:ImageLoader;
		
		public function MoodBox()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();	
			
			var thisLayout:VerticalLayout = new VerticalLayout();
			thisLayout.gap = 50;
			this.layout = thisLayout;
			
			moodLabel = new Label();
			moodLabel.text = "is";
			addChild(moodLabel);
			
			/*
			titleLabel = new Label();
			addChild(titleLabel);
			titleLabel.text = "Welcome to Emotilizer";
			titleLabel.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
			
			var fontDescription:FontDescription = new FontDescription( "", FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE );
			titleLabel.textRendererProperties.elementFormat = new ElementFormat( fontDescription, 108, 0xFFFFFF );
			
			*/
			
			var url:String = "http://emotilizer.club/emoapi/emotilizer/mood/" + CurrentFBUser.profile.id + "/10";
			var request:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(flash.events.Event.COMPLETE, function(e:flash.events.Event):void
			{
				var data:String = loader.data as String;
				var json:Object = JSON.parse(data);
				trace("Mood! " + json.average);
				
				var moodAverage:Number = Number(json.average);
				
				moodField = new Label();
				addChild(moodField);
				
				moodPic = new ImageLoader();
				moodPic.maintainAspectRatio = true;
				
				var moodText:String = "";
				if(moodAverage <= 3)
				{
					moodText = "Happy";
					moodPic.source = Root.assets.getTexture("happy");
				}
				else if(moodAverage >= 4 && moodAverage <= 6)
				{
					moodText = "Sad";
					moodPic.source = Root.assets.getTexture("sad");
				}
				else
				{
					moodText = "Angry";
					moodPic.source = Root.assets.getTexture("angry");
				}
				
				moodField.text = moodText;
				moodField.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
				
				var fontDescription:FontDescription = new FontDescription( "", FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE );
				moodField.textRendererProperties.elementFormat = new ElementFormat( fontDescription, 164, 0xFFFFFF );
				
				addChild(moodPic);
			});
			loader.load(request);
			
						
		}
		
		override protected function draw():void
		{
			super.draw();
			
			if(moodField)
			{
				moodLabel.x = (stage.stageWidth - moodLabel.width) / 2;
				moodField.x = (stage.stageWidth - moodField.width) / 2;
			}
			
			if(moodPic)
				moodPic.width = stage.stageWidth;
			
		}
	}
}