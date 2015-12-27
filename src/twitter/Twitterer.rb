require 'twitter'

class Twitterer
  
  def initialize(config)
    @config = config
    
    
    puts @config
  end
  
  def get_client
    return Twitter::REST::Client.new(@config)
  end
  
end



