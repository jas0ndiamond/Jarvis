require 'sinatra/base'

class Service < Sinatra::Base
  MESS = "SYSTEM ERROR: method missing"
  
  set :public_folder, './public'
  
  def initialize(app = nil, params = {})
    super(app)
  end
  
  def start; raise MESS; end
  def stop; raise MESS; end
    
  def restart
    
    stop
    sleep 10
    start
    
  end
end