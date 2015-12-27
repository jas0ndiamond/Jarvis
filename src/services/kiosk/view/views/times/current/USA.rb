require_relative "../../../../../../visualization/Visualizer.rb"
require 'active_support/time'

class CurrentTimesUSA < View
  
  def initialize
    super
    
    @data = Hash.new
    @schema = ["Time Zone", "Time"]
    @name =  "Current Times in the USA"
    
    @update_interval = 5
    @transition_interval = 20
  end
  
  def update_view
    @data.clear
    #date = DateTime.now
    Time.zone = 'America/New_York'
    @data["New York"] = Time.zone.now
      
    Time.zone = 'America/Chicago'
    @data["Chicago"] = Time.zone.now
      
    Time.zone = 'America/Denver'
    @data["Denver"] = Time.zone.now
      
    Time.zone = 'America/Los_Angeles'
    @data["Los Angeles"] = Time.zone.now
    
    Time.zone = 'America/Juneau'
    @data["Juneau"] = Time.zone.now
      
    Time.zone = 'Pacific/Honolulu'
    @data["Honolulu"] = Time.zone.now

  end
   
  def write_page
    raw_data_html =""
    
    @data.each do  |time_zone, time|
      raw_data_html += "<tr><td align='left'>" + time_zone.to_s + "</td><td style=\"text-align: right\">" + time.to_s.split(" ")[0,2].join(" ").gsub(' ', '&nbsp;') + "</td></tr>\n"
    end
    
    @page = Visualizer.build_data_table(@name, raw_data_html)    
  end
end