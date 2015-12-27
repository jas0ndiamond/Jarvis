require_relative "../Service.rb"

class Doorbell < Service
  
  def initialize(config)
    
    logfile = config["logfile"] unless !config["logfile"]
    logfile = '../logs/doorbell.log' unless logfile
    
    $logger = Logger.new(logfile, 0, 10 * 1024 * 1024) 
        
    @kiosks = config["kiosks"]
      
    @kiosks.each do |name, target|
      $logger.info("Loaded kiosk: " + name.to_s)
    end

    camera_config = config["camera_config"]
    camera_config_str = ""
    @camera_config_file = config["camera_config_file"]
    
    camera_config.each do |directive, value|
      camera_config_str << directive << " " << Regexp.escape(value) << "\n"
    end  
    
    
    File.write(camera_config_file, camera_config_str)
    $logger.info("Wrote camera config file " + camera_config_file)
    
    video_dir = camera_config["video_dir"]
    
    Dir.mkdir(video_dir) unless Dir.exists?(video_dir)
    $logger.info("Using video dir " + video_dir)
         
    @kill_timeout = 30    
    @motion_pid = nil
  end
  
  def start
    #syscall to start recording, check before launching/forking
    #./motion-mmal -c motion-mmalcam.conf
    
    #store pid
        
    #@motion_pid = Process.spawn(@motion_dir + "/motion-mmal -c " + @motion_dir + "/motion-mmalcam.conf") unless @motion_pid
    
    
  end
  
  def stop
  
    #kill pid to stop recording
      
    if @motion_pid
        #wait with timeout for any open filehandles
        
        i = 0
        while( `#{@video_handle_check_syscall}` && i< @kill_timeout)
          sleep(1)
          i+=1
        end
        
      Process.kill("HUP", motion_pid)
      @motion_pid = nil
    end
    
  end  
end

###################




