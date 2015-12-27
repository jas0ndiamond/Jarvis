require 'rubygems'
require 'logger'
require 'sinatra/base'
require 'require_all'

require_all "./services"

class Jarvis < Service
  
  
  
  def initialize(app = nil, params = {})
    
    super(app)
    
#    jarvis_config_file = params.fetch(:config_file, false)
#    
#    puts jarvis_config_file
#    
#    jarvis_config = JSON.parse(File.read(jarvis_config_file))
#    
#    logfile = jarvis_config["config"]["logfile"] unless !jarvis_config["config"]["logfile"]
#    logfile = '../logs/jarvis.log' unless logfile
#    
#    $logger = Logger.new(logfile, 0, 10 * 1024 * 1024)  
#    $logger.info("Loaded config from file")
    
  end
  
#  def startup(mac)
#    #wol to mac, this requires a hard link on the client side
#    system( "/usr/sbin/etherwake '#{mac}'")
#  end
  
  #should only be on master
  get '/' do
    "site management page"
  end
  
  get '/shutdown' do
    "invoke services shutdown"
  end

#move to wol manager  
#  get "/startup_machine" do
#    agent_name = params[:agent]
#      
#    #resolve mac for agent name
#  end
#  
#  get "/shutdown_machine" do
#    agent_name = params[:agent]
#      
#    #resolve ip/mac for agent name
#  end
end


