class Job
  
  attr_reader :thread
  attr_accessor :interval, :initial_delay, :running
  
  def initialize
    @initial_delay = 1 + Random.rand(5)
    @thread = nil
  end
  
  def start
    
    @running = true
    sleep @initial_delay
    
    if(!@thread)
      @thread = Thread.start{
        while(@running) do 
          run
          sleep interval
        end
      }
    end
  end
  
  def interval; @interval || 300; end
  
  def run; raise "Job run method not implemented"; end
    
  def stop
    @running = false
  end
  
end