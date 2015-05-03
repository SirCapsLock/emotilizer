package club.emotilizer.element
{
	import com.milkmangames.nativeextensions.GVFacebookFriend;
	
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import club.emotilizer.util.CurrentFBUser;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Quad;
	
	public class ProfileBox extends LayoutGroup
	{
		private var bg:Quad;
		private var profile:GVFacebookFriend;
		private var pic:ImageLoader;
		private var nameLabel:Label;
		private var mood:MoodBox;
		
		public function ProfileBox()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var thisLayout:VerticalLayout = new VerticalLayout();
			thisLayout.firstGap = 90;
			thisLayout.paddingBottom = 40;
			thisLayout.gap = 50;
			this.layout = thisLayout;
			
			if(CurrentFBUser.viewingFriend)
				profile = CurrentFBUser.selectedFriend;
			else
				profile = CurrentFBUser.profile;
						
			var picURL:String = "http://graph.facebook.com/" +  profile.id + "/picture?type=large";
			pic = new ImageLoader();
			pic.source = picURL;
			addChild(pic);
			
			/*
			titleLabel = new Label();
			addChild(titleLabel);
			titleLabel.text = "Welcome to Emotilizer";
			titleLabel.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
			
			var fontDescription:FontDescription = new FontDescription( "", FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE );
			titleLabel.textRendererProperties.elementFormat = new ElementFormat( fontDescription, 108, 0xFFFFFF );
			
			*/
			
			nameLabel = new Label();
			addChild(nameLabel);
			nameLabel.text = profile.name;
			nameLabel.styleNameList.add(Label.ALTERNATE_NAME_HEADING);
			
			var fontDescription:FontDescription = new FontDescription( "", FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE );
			nameLabel.textRendererProperties.elementFormat = new ElementFormat( fontDescription, 108, 0xFFFFFF );
			
			mood = new MoodBox();
			addChild(mood);
			
			//CurrentFBUser.selectedFriendID = null;
			
		}
		
		override protected function draw():void
		{
			super.draw();
			
			pic.x = (stage.stageWidth - pic.width) / 2;
			pic.scaleX = pic.scaleY = 2;
			nameLabel.x = (stage.stageWidth - nameLabel.width) / 2;
		}
	}
}