class CameraController
  
  def initialize(json)
    
#    @vid_dir = "/home/pi/m-video"
#    @motion_dir = "/home/pi/mmal"
    
    #parse json string for config
    
    #write 
    
    @timeout = 30    
    @motion_pid = nil
  end
  
  def startRecording
    #syscall to start recording, check before launching/forking
    #./motion-mmal -c motion-mmalcam.conf
    
    #store pid
        
    @motion_pid = Process.spawn(@motion_dir + "/motion-mmal -c " + @motion_dir + "/motion-mmalcam.conf") unless @motion_pid
    
    
  end
  
  def stopRecording
  
    #kill pid to stop recording
      
    if @motion_pid
        #wait with timeout for any open filehandles
        
        i = 0
        while( `#{@video_handle_check_syscall}` && i< @timeout)
          sleep(1)
          i+=1
        end
        
      Process.kill("HUP", motion_pid)
      @motion_pid = nil
    end
    
  end  
end

###################




