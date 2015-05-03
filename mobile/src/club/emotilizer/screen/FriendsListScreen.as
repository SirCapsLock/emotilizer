package club.emotilizer.screen
{
	import com.milkmangames.nativeextensions.GVFacebookFriend;
	import com.milkmangames.nativeextensions.GoViral;
	import com.milkmangames.nativeextensions.events.GVFacebookEvent;
	
	import flash.display3D.textures.Texture;
	
	import club.emotilizer.util.CurrentFBUser;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.data.ListCollection;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	
	public class FriendsListScreen extends PanelScreen
	{
		private var friends:Vector.<Object>;
		private var friendList:List;
		
		public function FriendsListScreen()
		{
			
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.headerFactory = function():Header
			{
				var backBtn:Button = new Button();
				backBtn.label = "Back";
				backBtn.styleNameList.add(Button.ALTERNATE_NAME_BACK_BUTTON);
				backBtn.addEventListener(Event.TRIGGERED, function(e:Event):void
				{
					dispatchEventWith("back");
				});
				var header:Header = new Header();
				header.leftItems = new <DisplayObject>[ backBtn ];
				
				return header;
			};
			this.title = "Your friends";
			
			friendList = new List();
			friendList.width = stage.stageWidth;
			friendList.height = stage.stageHeight;
			
			GoViral.goViral.requestFacebookFriends().addRequestListener(function(e:GVFacebookEvent):void
			{
				if(e.type == GVFacebookEvent.FB_REQUEST_RESPONSE)
				{
					CurrentFBUser.friends = e.friends;
					friends = new Vector.<Object>();
					for each(var friend:GVFacebookFriend in CurrentFBUser.friends)
					{
						trace("Friend: " + friend.name);
						var friendPic:ImageLoader = new ImageLoader();
						var friendPicURL:String = "http://graph.facebook.com/" +  friend.id + "/picture?type=normal";
						friendPic.source = friendPicURL;
						friends.push({ text: friend.name, thumbnail: friendPicURL, fbID: friend.id});
					}
					friendList.itemRendererProperties.labelField = "text";
					friendList.itemRendererProperties.iconSourceField = "thumbnail";
					friendList.dataProvider = new ListCollection(friends);
					addChild(friendList);
					
					friendList.addEventListener(Event.CHANGE, function(e:Event):void
					{
						var list:List = List(e.currentTarget);
						var item:Object = list.selectedItem;
						trace(item.text + " " + item.fbID + " selected");
						CurrentFBUser.selectedFriendID = item.fbID;
						CurrentFBUser.viewingFriend = true;
						dispatchEventWith("friendSelected");
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