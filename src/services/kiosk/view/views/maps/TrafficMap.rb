require_relative "../../../../../visualization/Visualizer.rb"

class TrafficMap < View

  def initialize(name, lat, long, zoom)
    
    super()
    
    @name = name
      
    @lat = lat
    @long = long
    @zoom = zoom
    
    @update_interval = 60
    @transition_interval = 90
  end
  
  def update_view
    #nothing -> we don't do any local work except deliver js that works with the gmaps api
  end
  
  def write_page
    @page =  Visualizer.build_title_box("<font style=\"font-weight:bold; font-size: 26px\">#{@name}</font>",10,10,350,35,"") << 
      "<script src=\"//maps.googleapis.com/maps/api/js?v=3.exp\" type=\"text/javascript\"></script>
    
      <div id=\"display\" style=\"height: 600px;\"></div>
    
      <script type=\"text/javascript\">
    
      var map = new google.maps.Map(document.getElementById(\"display\"), {
        center: new google.maps.LatLng(#{@lat}, #{@long}),
        zoom: #{@zoom},
        disableDefaultUI: true,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      });
        
      var trafficLayer = new google.maps.TrafficLayer();
      trafficLayer.setMap(map);
    </script>
    
    "
      
  end
end