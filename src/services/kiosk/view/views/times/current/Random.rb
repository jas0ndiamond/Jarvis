require_relative "../../../../../../visualization/Visualizer.rb"
require 'active_support/time'

class CurrentTimesRandom < View
  
  def initialize
    
    super
    
    @data = Hash.new
    
    @schema = ["Time Zone", "Time"]
      
    @name = "Current Times in random places"
    
    @update_interval = 5
    @transition_interval = 20
  end
  
  def update_view
    @data.clear
    
    available_time_zones = ActiveSupport::TimeZone.zones_map
    
    num_avail_timesones = available_time_zones.size
    max_timezones = 8
    
    timestamp_hash = Hash.new
    
    while (timestamp_hash.keys.length < max_timezones)
      index = rand(num_avail_timesones)
      time_zone_name = available_time_zones.keys[index]
      time_zone_val = available_time_zones[time_zone_name]
      
      Time.zone = available_time_zones[time_zone_name]
      current_time_in_zone = Time.zone.now
      timestamp_hash[current_time_in_zone.to_s] = time_zone_name.to_s
    end
    
    timestamp_hash.keys.sort.each do |time|
#      puts zone.to_s + " => " + time.to_s
      @data[timestamp_hash[time]] = time
    end
    
  end
   
  def write_page
    raw_data_html =""
    
    @data.each do  |time_zone, time|
      raw_data_html += "<tr><td align='left'>" + time_zone.to_s.gsub("\\(.+?\\)","") + "</td><td style=\"text-align: right\">" + time.to_s.split(" ")[0,2].join(" ").gsub(' ', '&nbsp;') + "</td></tr>\n"
    end
    
    @page = Visualizer.build_data_table(@name, raw_data_html)    
  end
end
