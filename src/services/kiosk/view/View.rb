require 'json'

class View
    MESS = "SYSTEM ERROR: method missing"
    
    attr_reader :name, :schema, :last_update_date, :page
    attr_accessor :transition_interval, :update_interval, :data, :show_marq, :show_last_updated, :show_toc
    
    def get_page
      view_markup= nil
      page_items = Hash.new
      
      Mutex.new.synchronize do
        write_page
        
        page_items["markup"] = @page
        page_items["name"] = @name
        page_items["update_time"] = last_update_date
        page_items["update_interval"] = update_interval
        page_items["transition_interval"] = transition_interval
        page_items["show_marq"] = show_marq
        page_items["show_last_updated"] = show_last_updated
        page_items["show_toc"] = show_toc
      end
      
      return JSON.generate(page_items)
    end
         
    def last_update_date; @last_update_date || DateTime.new(1970); end
    
    #interval in minutes
    def update_interval; @update_interval|| 1; end
      
    #interval in seconds
    def transition_interval; @transition_interval|| 60; end
      
    def show_marq
      return true unless @show_marq != nil 
      return @show_marq
    end
    
    def show_last_updated
      return true unless @show_last_updated != nil 
      return @show_last_updated
    end
    
    def show_toc
      return true unless @show_toc != nil 
      return @show_toc
    end
      
    def update
      
      retval = false 
      
      Mutex.new.synchronize do
        begin    
          update_view
      
          retval = true
        rescue Exception => e  
          puts e.message  
          puts e.backtrace.inspect 
        end
        
        @last_update_date = DateTime.now
      end
      return retval
    end
      
    def update_view; raise MESS; end
    def write_page; raise MESS;    end   
end