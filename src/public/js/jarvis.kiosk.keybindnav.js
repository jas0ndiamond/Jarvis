
	$(document).keydown(function(e)
	{
	    if (e.keyCode == 37) 
	    { 
			var nav_target = '/kiosk/prev'; 
			
			$.ajax
			({
		        type:"get",
		        url:nav_target,
		        dataType : 'json',
		        async: false
			});
			
			updateView(true);
	    }
	    else if (e.keyCode == 39)
	    {	    	
			var nav_target = '/kiosk/next'; 
			
			$.ajax
			({
		        type:"get",
		        url:nav_target,
		        dataType : 'json',
		        async: false
			});
			
			updateView(true);
	    }
	});
