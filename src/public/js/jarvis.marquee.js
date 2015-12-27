function loadMarquee()
{		
	var message ="";
		
	$('#marq')
		.bind('finished', function() {
			$('#marq').marquee("destroy");

			$.ajax({
				type : "get",
				url : "/kiosk/current",
				dataType : 'json',
				async : false
			}).success(
				function(data) 
				{
					message = data.name;
				}).error(function(error) {
			});

			$('#marq').html('Current view is <b>' + message + '</b> retrieved at:<b> ' + new Date()	+ "</b>")
			.marquee().find("*").addClass("kioskcore");
			
	}).marquee({
		duration : 3000
	}).find("*").addClass("kioskcore");
}