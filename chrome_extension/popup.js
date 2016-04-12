chrome.browserAction.onClicked.addListener(function(tab) {
  
  chrome.tabs.query({'active': true, 'lastFocusedWindow': true}, function (tabs) {
    var url = tabs[0].url;
    chrome.tabs.executeScript({
   		code: 'document.getElementById("new_url").value = "' + url + '"'
  	});
	});

});

// chrome.tabs.query({'active': true, 'lastFocusedWindow': true}, function (tabs) {
// 		var url = tabs[0].url;

// 		var newURL = "https://nmiresearcher.herokuapp.com/link";

// 			alert("here");
// 		});

// });