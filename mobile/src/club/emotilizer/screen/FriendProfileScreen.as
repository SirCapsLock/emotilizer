package club.emotilizer.screen
{
	import com.milkmangames.nativeextensions.GoViral;
	import com.milkmangames.nativeextensions.events.GVFacebookEvent;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import club.emotilizer.element.MoodBox;
	import club.emotilizer.element.ProfileBox;
	import club.emotilizer.util.CurrentFBUser;
	
	import feathers.controls.Button;
	import feathers.controls.PanelScreen;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class FriendProfileScreen extends PanelScreen
	{
		private var profileBox:ProfileBox;
		private var moodBox:MoodBox;
		private var friendsBtn:Button;
		
		public function FriendProfileScreen()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var thisLayout:VerticalLayout = new VerticalLayout();
			this.layout = thisLayout;
			
			this.title = "Your Friend";
			
			
			
		}
		
		override protected function draw():void
		{
			super.draw();
		}
	}
}