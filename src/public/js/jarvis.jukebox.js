function play()
{
	makeRequest("/pandora/play");
		
	$("#playButton").hide();
	$("#pauseButton").show();
	
	updatePlayer();
}

function pause()
{
	makeRequest("/pandora/pause");
			
	$("#pauseButton").hide();
	$("#playButton").show();
}

function next()
{
	makeRequest("/pandora/next");
	updatePlayer();
}

function upcoming()
{
	
}

function ban()
{
	makeRequest("/pandora/ban");
	updatePlayer();
}

function like()
{
	makeRequest("/pandora/like");
	
	//ruby/bash will update the now playing file
	
	//update player
	updatePlayer();
}

function volup()
{
	makeRequest("/pandora/volup");
}

function volreset()
{
	makeRequest("/pandora/volreset");
}

function voldown()
{
	makeRequest("/pandora/voldown");
}

function changeStation(stationNumber)
{
	makeRequest("/pandora/playstation?station=" + stationNumber);
	updatePlayer();
	updateStationList();
}

function getCurrentSong()
{
	return  $.parseJSON(makeRequest("/pandora/song_info"));
}

function updatePlayer()
{
	var result = getCurrentSong();

	//play or pause depending on is_playing
	
	var title = result.song.title
	
	//show if song liked or not depending on rating 0 for nothing, 1 for like
	if(result.song.rating == "1")
	{
		title += " &#10084;";
		$("#likeButton").prop('disabled', true);
	}
	else
	{
		$("#likeButton").prop('disabled', false);
	}
	
	//update playing vs paused status. the player can be reloaded mid-song
	if(result.song.is_playing == true)
	{
		$("#playButton").hide();
		$("#pauseButton").show();
	}
	else
	{
		$("#playButton").show();
		$("#pauseButton").hide();
	}
	
	var songHtml =  "<b>" + title + "</b><br>" +
		result.song.artist + "<br>" +
		"<i>" + result.song.album + "</i> on " + result.song.stationName
	
	$("#songinfo").html(songHtml);
	
	//update upcoming list
}

function updateStationList()
{
	var result =  $.parseJSON(makeRequest("/pandora/getstations"));
	
	$("#stationSelect").empty();
	
	$.each(result, function(key, value) 
    {
    	$("#stationSelect").append("<option value=\"" + key + "\">" + value + '</option>' );
    });
    
    //select current station
    
    var currentSong = getCurrentSong();
        
    $("#stationSelect option").filter(function() {
    	return $(this).text() == currentSong.song.stationName; 
	}).prop('selected', true);
}

function makeRequest(requestUrl)
{
	var result = $.ajax
	({
        type:"get",
        url:requestUrl,
        dataType : 'json',
        async: false
	})
    .error (function()
    {
		//alert("Error issuing request" + requestUrl);
	}).responseText;
		
	return result;
}