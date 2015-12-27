function updateView(force)
{
	//web request to /kiosk/current
	//check update time?
	//set page title
	//html to targetDiv
	
	//see if the view has changed or an update is available
	
	$.ajax
	({
        type:"get",
        url:"/kiosk/current",
        dataType : 'json'
	})
	.success(function(data)
    {
    	var currentViewName = $("#currentViewName").text();
		var lastUpdateText = $("#lastUpdate").text();
		var lastUpdateDate = new Date(); 
		var newUpdateDate = data.update_time;
		var newViewName = data.name;
		
		if( lastUpdateText == "" )
		{
			lastUpdateDate.setTime( 0 );
		}
		
		//$("#debug").html( "| Update check at: " + new Date() +": " +  force + " | " + newViewName + " vs " + currentViewName + " | " + Date.parse(newUpdateDate) + " vs " +  Date.parse(lastUpdateText) + "|\n");
				
		//should we update
		if(force == true || (newViewName != currentViewName || Date.parse(newUpdateDate) > Date.parse(lastUpdateText) ))
		{	
			//clear the existing header of non-kioskcore stuff
			$("#kioskhead script:not(.kioskcore)").remove();
			$("#kioskhead link:not(.kioskcore)").remove();
			
			//$("#kioskhead").removeClass('@-moz-keyframes*');
			//$("#kioskhead style:not(.kioskcore)").remove();
		
			//clear the existing body of non-kioskcore stuff
			$("#kioskbody :not(.kioskcore)").remove();
		
			//replace the html targetDiv		
			$('#kioskbody').prepend(data.markup.replace("\\",""));
			
			//write new update date
			$("#lastUpdate").html(newUpdateDate);
			
			//write new view name
			$("#currentViewName").html(newViewName);	
			
			//show/hide the marquee
			if(data.show_marq == true)
			{
				$("#marq").show();
				$("#marq").trigger("resume");		
			}
			else
			{
				$("#marq").hide();	
				$("#marq").trigger("pause");	
			}	
			
			//show/hide the toc
			if(data.show_toc == true)
			{

			}
			else
			{

			}	
			
			//show/hide the update bar
			if(data.show_last_updated == true)
			{

			}
			else
			{
	
			}	
			
			//update the transition interval
			//convert seconds to milliseconds (*=1000), then make a percentage (/=100)
			$('#progress_increment').html(data.transition_interval * 10);
			
			//reset progress bar
			$('#progressbar').progressbar('option', 'value', 0);
		}
    }).error (function(error)
    {
		//alert("Error getting current view: " + error);
	});
}

function progress() 
{
  var val = $( "#progressbar" ).progressbar( "option", "value" ) || 0;
  $( "#progressbar" ).progressbar( "option", "value", val + 1 );
  
  if ( val <= 99 ) 
  {
    setTimeout(progress, $("#progress_increment").text());
  }
}

function pageTransition()
{	
	//non-ajax
	var nav_next_target = '/kiosk/next_nice'; 
	
	$.ajax
	({
        type:"get",
        url:nav_next_target,
        dataType : 'json',
        async: false
	}).error (function(error)
    {
		//alert("Error executing page transition: " + error);
	});

	//force view update
	updateView(true);
}
