
document.addEventListener('DOMContentLoaded', function () {

	chrome.tabs.query({'active': true, 'lastFocusedWindow': true}, function (tabs) {
  		var url = tabs[0].url;

  		var newURL = "https://nmiresearcher.herokuapp.com/link";
			chrome.tabs.create({ url: newURL });

	});
});