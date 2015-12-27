$( document ).ready(
		function() 
        { 
	      loadMarquee();
	      //$("#marq").hide();
			
          //grab the first view
          updateView(true);
          
          //passive check for updates
          //must be in a function
          setInterval(  function(){updateView(false);} , 2750);
                    
          $( "#progressbar" ).progressbar({   value: false, change: function() {}, complete: pageTransition });
          $( "#transition_area").find("*").addClass("kioskcore");
          
          progress();
        }
);