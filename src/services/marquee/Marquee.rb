require_relative "../../services/Service.rb"

class Marquee < Service

  @@webdir = "marquee"
  
  def initialize(app = nil, params = {})
    
    super
    
    config = params.fetch(:config, false)
    
    #logfile = config["logfile"] unless !config["logfile"]
    #logfile = '../logs/marquee.log' unless logfile
    
    #$logger = Logger.new(logfile, 0, 10 * 1024 * 1024) 
    
    #$logger.info("Starting Marquee")
    
    @messages = Array.new
  end
  
  def add_message(message)
    
    #message can be html-> no js
    
    #timestamp
    
  end

  def add_message_with_age(message, age)

  end
  
  def add_message_onetime(message)
    
  end
  
  def add_message_to_top(message)
    #add to top, and remove upon get
  end
  
  def get
    #get the next message
    #message = @messages.pop
    message = "test message"
    
    #handle the message, add it back if necessary
    #remove from messages if too old, or set to expire 
    
    return message
  end
  
  def clear
    @messages.clear()
  end
  
  get "/#{@@webdir}/marquee/add/:msg" do
    message = params[:msg]
      
    #add the message to the store  
  end 
  
  get "/#{@@webdir}/marquee/get" do
    
      
      
  end 
  
end