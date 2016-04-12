chrome.browserAction.onClicked.addListener(function(tab) {
  
  chrome.tabs.query({'active': true, 'lastFocusedWindow': true}, function (tabs) {
    var url = tabs[0].url;
    
    chrome.tabs.create({ url: "https://nmiresearcher.herokuapp.com/link", active:true}, function(){
    	
    	chrome.tabs.executeScript({
   			code: 'document.getElementById("new_url").value = "' + url + '"; document.forms["new_form"].submit();'
  		});
  	});

	});

});