function initIFrame() {
	chrome.tabs.query({
		active : true,
		currentWindow : true
	}, function(tabs) {
		var expiry = new Date(parseInt(localStorage.expiryTime));
		var now = new Date();
		if (localStorage.accessToken && now < expiry) {
			$('#frame').show();
			$('#frame').attr(
					'src',
					"http://anycom.herokuapp.com?url="
							+ encodeURIComponent(tabs[0].url) + "&accessToken="
							+ encodeURIComponent(localStorage.accessToken));
		} else {
			$('#frame').hide();
			loginfacebook(initIFrame);
		}
	});
}

document.addEventListener('DOMContentLoaded', function() {
	initIFrame();
});