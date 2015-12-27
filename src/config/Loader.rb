require 'json'
require 'require_all'

require_all "jobs/**/*.rb"

#get a json file, parse it into services/jobs/etc, mapped to their json configs

class Loader
  
  SERVICES_DIRECTIVE = "services"
  JOBS_DIRECTIVE = "jobs"
  CONFIG_DIRECTIVE = "config"
  
  #maybe map english names to class names
  SERVICES = 
  {
    "Jukebox" => nil,
    #"Pandora" => nil,
    "Kiosk" => nil,
    "Doorbell" => nil,
    "ShoppingList" => nil,
    "Jarvis" => nil,
    "Marquee" => nil
  }
  
  JOBS = 
  {
    "Backup" => nil,
    "NetworkKeepAlive" => nil,
    "ExternalIPNotifier" => nil
  }
    
  CONFIG = 
  {
    
  }
    
  
  attr_accessor :config_file, :parsed_config
  
  def initialize(config_file)
    load(config_file)
  end
  
  def load(config_file)
    @config_file = config_file
    
    @parsed_config = JSON.parse(File.read(@config_file))
  end
  
  def get_config
    general_config = Hash.new
    
    if(@parsed_config[CONFIG_DIRECTIVE])
      @parsed_config[CONFIG_DIRECTIVE].each do |general_config_directive, config|
              
        general_config[general_config_directive] = config unless CONFIG[general_config_directive]
        
      end
    end
    
    return general_config
  end
  
  def get_jobs_config
    jobs = Array.new
    
    if(@parsed_config[JOBS_DIRECTIVE])
      @parsed_config[JOBS_DIRECTIVE].each do |job, config|
              
        #jobs[job] = config unless JOBS[job]
        
        if(job == "NetworkKeepAlive")
          jobs.push(NetworkKeepAlive.new(config))
        elsif job == "ExternalIPNotifier"
          jobs.push(ExternalIPNotifier.new(config))
        end
        
      end
    end
    
    return jobs
  end
  
  def get_services_config
    
    services = Hash.new
    
    if(@parsed_config[SERVICES_DIRECTIVE])
      @parsed_config[SERVICES_DIRECTIVE].each do |service, config|
              
        services[service] = config unless SERVICES[service]
        
      end
    end
    
    return services
    
  end
  
end