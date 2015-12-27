require 'logger'
require 'sinatra/base'
require 'liquid'

require_relative "../../services/Service.rb"

class Jukebox < Service
  
  @@webdir = "jukebox"

  @@is_playing = false
  
  def initialize(app = nil, params = {})
    
    super
    
    config = params.fetch(:config, false)
    
    logfile = config["logfile"] unless !config["logfile"]
    logfile = '../logs/jukebox.log' unless logfile
    
    $logger = Logger.new(logfile, 0, 10 * 1024 * 1024) 
      
    #grab users, and grab each user's music apps/config
      #for each user, launch a jukebox service
    
    @services = Array.new
    
    puts "===================="
    config.each do |jarvis_user,configured_services|
        configured_services.each do |configured_service, service_config|
          #puts "" << jarvis_user << " " << configured_service.to_s
          
          puts "" << jarvis_user << " " << configured_service << " " << service_config.to_s
          
          if configured_service == "Pandora"
            #pandora.add(user, config)
          elsif configured_service == "mpd"
            
          end
          
        end
    end
    
    #do not invoke service stop -> no need to launch a bunch of processes with possibly long-idle sessions
  end
  
  def start

    #for each user's configured service, invoke service start

  end
  
  def stop
    
    #for each user's configured service, invoke service stop
    
  end
  
  get "/#{@@webdir}" do
    
    #ui bound with web requests to manipulate fifo on fs
    
    title = "Jukebox"
    
    return '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">' <<
        "\n<html><head>\n" << 
        "<title>" << title << "</title>\n" << 
        "<META http-equiv=Content-Type content=\"text/html; charset=utf-8\">\n" <<
        "<link rel=\"icon\" href=\"favicon.ico?v=" << rand(1000).to_s << "\" type=\"image/x-icon\">\n" << 
        "<link rel=\"shortcut icon\" href=\"favicon.ico?v=" << rand(1000).to_s << "\" type=\"image/x-icon\">\n" << 
        "</head>\n"<<
        "<body>\n"<< 
        "<script type=\"text/javascript\" src=\"js/jukebox.js\"></script>\n" <<
        "<script type=\"text/javascript\" src=\"js/jquery-1.11.3.min.js\"></script>\n" <<
        "<script type=\"text/javascript\" src=\"jquery-ui-1.11.4.custom/jquery-ui.min.js\"></script>\n" <<
        '<link rel="stylesheet" href="//http://code.jquery.com/ui/1.11.4/themes/redmond/jquery-ui.min.css">' << "\n"<<
          
        #tabs for users
          #tabs for configured music services
          #music service endpoints calculated from service name and user name
        
        "</body></html>"
  end
end