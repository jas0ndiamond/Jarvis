require 'sinatra/base'

class WakeOnLan < Sinatra::Base

  def initialize(app = nil, params = {})
    
    super
    
    @config = params.fetch(:config, false)
    
  end

  get "/wol" do
  
    #load wol targets from config
    #buttons with mac and optional hostname
    
    #detect if host is already online?
      #only if host is given
    
    #box to specify mac and button to send

  end
end