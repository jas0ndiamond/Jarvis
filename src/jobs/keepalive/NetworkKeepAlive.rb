require 'net/ping'
require 'logger'
require_relative "../Job.rb"

class NetworkKeepAlive < Job
  
  attr_accessor :target, :protocol
  
  def initialize(config)
        
    super()
    
    logfile = config["logfile"] unless !config["logfile"]
    logfile = '../logs/keepalive.log' unless logfile
    $logger = Logger.new(logfile, 0, 10 * 1024 * 1024) 

    
    @target = config["target"] unless !config["target"]
    @target = target unless @target
    
    @interval = config["interval"] unless !config["interval"]
    @interval = interval unless @interval
    
    @protocol = config["protocol"] unless !config["protocol"]
    @protocol = protocol unless @protocol
      
    $logger.info "Start keepalive ping to " + 
        target.to_s + " and protocol: " + 
        protocol.to_s
  end
  
  def target
    @target || "127.0.0.1"
  end
  
  def protocol
    @protocol || "http"
  end
  
  def run
    Net::Ping::TCP.new(target, protocol).ping?
  end
  

end