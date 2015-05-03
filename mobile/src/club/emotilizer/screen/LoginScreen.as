package club.emotilizer.screen
{
	import com.milkmangames.nativeextensions.GoViral;
	import com.milkmangames.nativeextensions.events.GVFacebookEvent;
	
	import flash.events.Event;
	
	import feathers.controls.Screen;
	
	public class LoginScreen extends Screen
	{
		public function LoginScreen()
		{
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			if(GoViral.goViral.isFacebookSupported())
			{
				GoViral.goViral.initFacebook("1606394502949988","");
				
				GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGGED_IN,onFacebookEvent);
				GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGGED_OUT,onFacebookEvent);
				GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGIN_CANCELED,onFacebookEvent);
				GoViral.goViral.addEventListener(GVFacebookEvent.FB_LOGIN_FAILED,onFacebookEvent);
				
				if(!GoViral.goViral.isFacebookAuthenticated())
					GoViral.goViral.authenticateWithFacebook("public_profile,user_friends,email,user_posts");
				else
					dispatchEventWith("complete");
				
			}
			else
			{
				trace("**WARNING: GOVIRAL FACEBOOK NOT SUPPORTED**");
			}
			
		}
		
		protected function onFacebookEvent(e:GVFacebookEvent):void
		{
			trace("FACEBOOK: " + e.type);
			
			if(e.type == GVFacebookEvent.FB_LOGGED_IN)
			{
				dispatchEventWith("complete");
			}
		}
		
		override protected function draw():void
		{
			super.draw();
		}
		
	}
}