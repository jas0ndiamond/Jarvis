class MonitorController
  
  def initialize
  end
  
  def get_display
        #get the display
        #first try env
        display = `/bin/echo $DISPLAY`
        
        if(!display)
          display = `pushd /tmp/.X11-unix >/dev/null && for x in X*; do /bin/echo ":${x#X}"; done; popd > /dev/null`
        else
          display.chomp  
        end
        
        return display
  end
  
  def turn_on
    #get display first
    
    `/usr/bin/xset -display #{display} dpms force on; xdotool mousemove 0 5; xdotool mousemove 0 0`
  end
  
  def turn_off
    #get display
    
    `/usr/bin/xset -display #{display} dpms force off;`
  end
end

m = MonitorController.new

puts m.get_display()