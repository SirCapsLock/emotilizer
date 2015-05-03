package club.emotilizer.util
{
	import com.milkmangames.nativeextensions.GVFacebookFriend;

	public class CurrentFBUser
	{
		private static var _profile:GVFacebookFriend;
		private static var _friends:Vector.<GVFacebookFriend>;
		private static var _selectedFriendID:String;
		private static var _selectedFriend:GVFacebookFriend;
		private static var _viewingFriend:Boolean;
		
		public static function get viewingFriend():Boolean
		{
			return _viewingFriend;
		}

		public static function set viewingFriend(value:Boolean):void
		{
			_viewingFriend = value;
		}

		public static function get selectedFriend():GVFacebookFriend
		{
			return _selectedFriend;
		}

		public static function set selectedFriend(value:GVFacebookFriend):void
		{
			_selectedFriend = value;
		}

		public static function get selectedFriendID():String
		{
			return _selectedFriendID;
		}

		public static function set selectedFriendID(value:String):void
		{
			_selectedFriendID = value;
			selectedFriend = getFriend(_selectedFriendID);
		}

		public static function get friends():Vector.<GVFacebookFriend>
		{
			return _friends;
		}
		
		public static function set friends(value:Vector.<GVFacebookFriend>):void
		{
			_friends = value;
		}
		
		public static function get profile():GVFacebookFriend
		{
			return _profile;
		}
		
		public static function set profile(value:GVFacebookFriend):void
		{
			_profile = value;
		}
		
		public static function getFriend(fbID:String):GVFacebookFriend
		{
			var foundFriend:GVFacebookFriend = null;
			friends.forEach(function(friend:GVFacebookFriend, ...args):void
			{
				if (friend.id == fbID)
					foundFriend = friend;
			});
			
			return foundFriend;
		}

	}
}