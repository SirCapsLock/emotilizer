package club.emotilizer
{
	import club.emotilizer.screen.FriendsListScreen;
	import club.emotilizer.screen.IntroScreen;
	import club.emotilizer.screen.LoginScreen;
	import club.emotilizer.screen.ProfileScreen;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.FeathersControl;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.RGBThemeGlober;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class Root extends Sprite
	{
		public static const SCREEN_INTRO:String = "IntroScreen";
		public static const SCREEN_LOGIN:String = "LoginScreen";
		public static const SCREEN_PROFILE:String = "ProfileScreen";
		public static const SCREEN_FRIENDS:String = "FriendsScreen";
		
		private static var _assets:AssetManager;
		private static var _filterType:String;
		
		private var navigator:ScreenNavigator;
		private var transitionManager:ScreenSlidingStackTransitionManager;
		
		public function Root()
		{
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage():void
		{
			
		}
		
		public function start(assets:AssetManager):void
		{
			new RGBThemeGlober();
			
			_assets = assets;
			navigator = new ScreenNavigator();
			
			navigator.width = stage.stageWidth;
			navigator.height = stage.stageHeight;
			
			transitionManager = new ScreenSlidingStackTransitionManager(navigator);
			addChild(navigator);
			
			navigator.addScreen(SCREEN_INTRO, new ScreenNavigatorItem( IntroScreen,
				{
					complete:SCREEN_LOGIN		
				}
			));
			
			navigator.addScreen(SCREEN_LOGIN, new ScreenNavigatorItem( LoginScreen,
				{
					complete: SCREEN_PROFILE
				}
			));
			
			navigator.addScreen(SCREEN_PROFILE, new ScreenNavigatorItem( ProfileScreen,
				{
					friends:SCREEN_FRIENDS,
					back:SCREEN_INTRO
				}
			));
			
			navigator.addScreen(SCREEN_FRIENDS, new ScreenNavigatorItem( FriendsListScreen,
				{
					back: SCREEN_PROFILE,
					friendSelected: SCREEN_PROFILE
				}
			));
			
			navigator.showScreen(SCREEN_INTRO);
			
		}
		
		public static function get assets():AssetManager
		{
			return _assets;
		}
		
		public static function set assets(value:AssetManager):void
		{
			_assets = value;
		}
		
		
	}
}




