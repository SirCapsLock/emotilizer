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
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ProfileScreen extends PanelScreen
	{
		private var bg:Image;		
		private var profileBox:ProfileBox;
		private var moodBox:MoodBox;
		private var friendsBtn:Button;
		
		public function ProfileScreen()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var thisLayout:VerticalLayout = new VerticalLayout();
			this.layout = thisLayout;
			
			this.title = "Emotilizer";
			
			bg = new Image(Texture.fromColor(stage.stageWidth, stage.stageHeight, 0xFF0000));
			addChild(bg);
			
			this.backgroundSkin = bg;
			
			var isFriendProfile:Boolean = CurrentFBUser.selectedFriendID ? true : false;
			
			this.headerFactory = function():Header
			{
				var header:Header = new Header();
				
				var backBtn:Button = new Button();
				backBtn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
				backBtn.label = "Back";
				backBtn.addEventListener(starling.events.Event.TRIGGERED, function(e:starling.events.Event)
				{
					CurrentFBUser.viewingFriend = false;
					dispatchEventWith("back");
				});
				header.leftItems = new <DisplayObject>[ backBtn ];
				
				return header;
			};
			
			
			
			GoViral.goViral.requestMyFacebookProfile().addRequestListener(function(e:GVFacebookEvent):void
			{
				if(e.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
				{
					CurrentFBUser.profile = e.friends[0];
					
					profileBox = new ProfileBox();
					addChild(profileBox);
					
					friendsBtn = new Button();
					friendsBtn.label = "See your friends";
					friendsBtn.styleNameList.add(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON);
					friendsBtn.addEventListener(starling.events.Event.TRIGGERED, function(e:starling.events.Event):void
					{
						dispatchEventWith("friends");
					});
					
					addChild(friendsBtn);
					
					if(CurrentFBUser.viewingFriend)
						return;
					
					//collect posts
					GoViral.goViral.facebookGraphRequest("me/feed","GET", {limit:20}).addRequestListener(function(e:GVFacebookEvent):void
					{
						if(e.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
						{
							var data:String = e.jsonData;
							var json:Object = JSON.parse(data);
							for each(var post:Object in json.data)
							{
								var url:String = "http://emotilizer.club/emoapi/emotilizer/sentence/" + CurrentFBUser.profile.id;
								trace("URL: " + url);
								var request:URLRequest = new URLRequest(url);
								request.method = URLRequestMethod.POST;
								
								var urlVars:URLVariables = new URLVariables();
								trace("Message: " + post.message);
								urlVars.statement = post.message;
								request.data = urlVars;
								
								var loader:URLLoader = new URLLoader();
								loader.dataFormat = URLLoaderDataFormat.TEXT;
								loader.addEventListener(flash.events.Event.COMPLETE, function(e:flash.events.Event):void
								{
									var data:String = loader.data as String;
									trace("Data: " + data);
								});
								loader.load(request);								
							}
						}
						else
						{
							trace("ERROR: " + e.errorMessage);
						}
					});
					
				}
			});
			
		}
		
		override protected function draw():void
		{
			super.draw();
			
			
			
			
		}
		
	}
}