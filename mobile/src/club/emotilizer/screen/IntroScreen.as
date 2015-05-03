package club.emotilizer.screen
{
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import club.emotilizer.Root;
	import club.emotilizer.util.CurrentFBUser;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.examples.componentsExplorer.data.EmbeddedAssets;
	import feathers.layout.VerticalLayout;
	import feathers.themes.flashdaily.ButtonExtra;
	
	import starling.events.Event;
	
	public class IntroScreen extends Screen
	{
		private var logo:ImageLoader;
		private var titleLabel:Label;
		private var fbBtn:Button;
		
		public function IntroScreen()
		{
		}
		
		override protected function initialize():void
		{
			super.draw();	
			
			var thisLayout:VerticalLayout = new VerticalLayout();
			this.layout = thisLayout;
			
			titleLabel = new Label();
			addChild(titleLabel);
			titleLabel.text = "Welcome to Emotilizer";
			titleLabel.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
			
			var fontDescription:FontDescription = new FontDescription( "", FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE );
			titleLabel.textRendererProperties.elementFormat = new ElementFormat( fontDescription, 108, 0xFFFFFF );
			
			logo = new ImageLoader();
			logo.source = Root.assets.getTexture("logo_only");
			addChild(logo);
			
			fbBtn = new Button();
			fbBtn.label = "Login with Facebook";
			fbBtn.styleNameList.add(ButtonExtra.ALTERNATE_NAME_FACEBOOK_BUTTON);
			fbBtn.labelFactory = function():ITextRenderer
			{
				var textRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				var fontDescription:FontDescription = new FontDescription( "", FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE );
				textRenderer.elementFormat = new ElementFormat( fontDescription, 108, 0xFFFFFF );
				return textRenderer;
			};
			var fbIconLoader:ImageLoader = new ImageLoader();
			fbIconLoader.source = EmbeddedAssets.FB_ICON;
			fbBtn.defaultIcon = fbIconLoader;
			addChild(fbBtn);
			
			fbBtn.addEventListener(Event.TRIGGERED, function(e:Event):void
			{
				dispatchEventWith("complete");
			});
			
			CurrentFBUser.viewingFriend = false;
		}
		
		override protected function draw():void
		{
			super.draw();
			
			logo.x = (stage.stageWidth - logo.width) / 2;
			logo.y = 120;
			logo.scaleX = logo.scaleY = 2;
			 
			titleLabel.x = (stage.stageWidth - titleLabel.width) / 2;
			titleLabel.y = stage.stageHeight * .2;
			
			fbBtn.x = (stage.stageWidth - fbBtn.width) / 2;
			fbBtn.y = (stage.stageHeight - fbBtn.height) / 2;
			fbBtn.width = .7 * stage.stageWidth;
			fbBtn.height = .2 * stage.stageHeight;
			
		}
	}
}