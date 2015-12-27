require 'date'
require 'require_all'
require_relative "View.rb"
require_all "services/kiosk/view/views"

class ViewMgr
  
  def initialize
    @play = true
    @current_view = 0
    @rotating_views = []    
  end
  
  def add_view(view )
    Mutex.new.synchronize do
      @rotating_views.push(view)
    end
  end
  
  def update_views

    #update current and current + 1's view for the next transition
    #prev transition will likely have already been updated
    
    #return unless @play
        
    
    now = DateTime.now
    view_threads = []
    
    return if @rotating_views.size() == 0
      
    Mutex.new.synchronize do
        #puts "Current view is " + @rotating_views[@current_view].get_name + " next view is " + @rotating_views[(@current_view + 1)  % @rotating_views.length].get_name
          
        [@rotating_views[@current_view], @rotating_views[(@current_view + 1)  % @rotating_views.length] ].each { |view|
#          puts "============"
#          puts "Queued " + view.get_name
#          puts "View " + view.get_name + " was last updated minutes ago: " + ((now - view.last_update_date) * 24*60).to_i.to_s unless view.last_update_date == nil
        
          if(view.last_update_date == nil || ((now - view.last_update_date) * 24*60).to_i > view.update_interval)
            #puts "updating view for " + view.get_name
            view_threads.push(Thread.new{view.update})
          else
            #puts "skipping update " + view.name
          end
       }
    end
      
    view_threads.each { |t| t.join}
  end
  
  
  def get_current_view
    current_view = nil
    Mutex.new.synchronize do
      current_view = @rotating_views[@current_view]
    end
    return current_view
  end
  
  def should_nice_nav
    
    #compare current time to last nav time
    
    return true
  end
  
  def nav_next
    Mutex.new.synchronize do
      if @play
        @current_view += 1
        @current_view %=  @rotating_views.length
      end
    end
  end
      
  def nav_next_nice
      nav_next if should_nice_nav
  end
        
  def nav_prev_nice
    nav_prev if should_nice_nav
  end
      
  def nav_rand
    Mutex.new.synchronize do
      @current_view = rand(@rotating_views.length)
    end
  end
  
  def nav_prev
    Mutex.new.synchronize do
      if @play
        @current_view -= 1
        @current_view = @rotating_views.length - 1 unless @current_view >= 0
      end
    end
  end
  
def nav_prev_nice
  nav_prev
end

def nav_seek(view_name)
    Mutex.new.synchronize do
      #search for view index
      seek_index = -1
      i=0
      while i < @rotating_views.length
        
        if(@rotating_views[i].get_name == view_name)
          seek_index = i
          break  
        else
          i+= 1
        end
      end
      
      @current_view = seek_index unless seek_index == -1
    end
end
  
  def nav_pause
    Mutex.new.synchronize do
      @play = false
    end
  end
  
  def nav_play
    Mutex.new.synchronize do
      @play = true
    end
  end
end

