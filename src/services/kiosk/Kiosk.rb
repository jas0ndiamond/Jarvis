require_relative "view/ViewMgr.rb"
require_relative "../../services/Service.rb"
require_relative "../../visualization/Visualizer.rb"

require 'rubygems'
require 'logger'
require 'json'
require 'sinatra/base'

class Kiosk < Service
  
  attr_reader :nav_prev,:nav_next, :nav_next_nice,:nav_prev_nice, :nav_pause, :nav_play, :nav_seek,:nav_rand,:play
  
  @@webdir = "kiosk"
  
  def initialize(app = nil, params = {})
    
    super
    
    config = params.fetch(:config, false)
    
    logfile = config["logfile"] unless !config["logfile"]
    logfile = '../logs/kiosk.log' unless logfile
    
    $logger = Logger.new(logfile, 0, 10 * 1024 * 1024) 
    
    $logger.info("Starting Kiosk")
    
    @nav_prev = 1
    @nav_prev_nice = 7
    @nav_next = 2
    @nav_next_nice = 6
    @nav_pause = 3
    @nav_play = 4
    @nav_rand = 5
    @nav_seek = 0
    
    @marquee = Marquee.new
    @vmgr = ViewMgr.new
    
    config["views"].each do |view|
  
      $logger.info("Loading view " + view.to_json)
      
      this_view_name = view["name"] 
      
      if(this_view_name)
        
        this_view = nil
        
        
        if(this_view_name == "KioskInfo")
          this_view = KioskInfo.new
        elsif(this_view_name == "SystemInfo")
            this_view = SystemInfo.new
        elsif this_view_name == "Feed"
          this_view = Feed.new(view["feed_name"], view["uri"])
        elsif this_view_name == "WebsiteFeed"
          this_view = WebsiteFeed.new(view["feed_name"], view["uri"], view["width"], view["height"])
        elsif this_view_name == "TrafficMap"
          this_view = TrafficMap.new(view["map_name"], view["lat"], view["long"], view["zoom"])
        else
          $logger.error("Malformed view - name not recognized")
        end
        
        
        @vmgr.add_view(this_view) unless !this_view
            
      else
        $logger.error("Malformed view - no name provided")
      end  
      
      
    end
    
  end
  
  def nav(action, name = nil)
    if action == @nav_prev
      @vmgr.nav_prev
    elsif action == @nav_next
      @vmgr.nav_next
    elsif action == @nav_next_nice
       @vmgr.nav_next_nice
    elsif action == @nav_pause
      @vmgr.nav_pause
    elsif action == @nav_play 
      @vmgr.nav_play
    elsif action == @nav_rand
      @vmgr.nav_rand
    elsif action == @nav_seek && name
      @vmgr.nav_seek(name)
    else  
      $logger.error "unsupported nav " + action + ": " + name
    end
  end
  
  def get_current_view
    @vmgr.update_views
    return @vmgr.get_current_view
  end
  
  def start
  end
  
  def stop
  end
  
    ###########################################
    #kiosk targets
    get "/#{@@webdir}" do    
      #page with a content div, javascript updates the div with web requests to current
      return Visualizer.build_header("Kiosk") <<
        Visualizer.build_kiosk_body << 
        Visualizer.build_marquee << 
        Visualizer.build_transition_prog_bar <<
        Visualizer.build_footer
    end
    
    get "/#{@@webdir}/current" do
      get_current_view.get_page
    end
    
    get "/#{@@webdir}/next" do
      nav(@nav_next)  
    end
    
    get "/#{@@webdir}/next_nice" do
      nav(@nav_next_nice)  
    end
    
    get "/#{@@webdir}/prev_nice" do
      nav(@nav_prev_nice)  
    end
    
    get "/#{@@webdir}/rand" do
      nav(@nav_rand)
    end
    
    get "/#{@@webdir}/pause" do
      nav(@nav_pause)
    end
    
    get "/#{@@webdir}/play" do
      nav(@nav_play)
    end
    
    get "/#{@@webdir}/prev" do
      nav(@nav_prev)
    end
      
    get "/#{@@webdir}/seek/:feed" do
        feed_name = params[:feed]
          
        nav(@nav_seek, feed_name)
    end
  
end



