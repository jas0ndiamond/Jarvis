require_relative "../../../../../../visualization/Visualizer.rb"
require 'active_support/time'

class TimeDifference < View
   
  def initialize
    super
    
    @data = Hash.new
    
    @name = "Countdowns/ups"
    @schema = ["Date", "Name"]
      
    @update_interval = 5
    @transition_interval = 30
  end
  
  def update_view
    @data.clear
    
    @data["Birthday"] = Time.new("2016", "03", "27", "00", "00", "00")
      
    @data["St Pats Day"] = Time.new("2016", "03", "17", "00", "00", "00")
    
    #@data["Worked @ Sutherland"] =  Time.new("2006", "12", "26", "07", "00", "00")
    @data["Worked @ Thingworx"] =  Time.new("2014", "12", "01", "07", "00", "00")
      
    @data["Started Playing Hockey"] =  Time.new("1990", "06", "01", "18", "00", "00")
      
    @data["Graduated RIT"] =  Time.new("2010", "06", "01", "11", "00", "00")
      
    @data["Ticker Project Lifetime"] =  Time.new("2014", "03", "31", "19", "25", "00")
      
  end
  
  def write_page; 
    retval = ""
    
    Time.zone = 'America/New_York'
    right_now = Time.zone.now
    
    raw_data_html =""
    
    i = 0 
    @data.each do  |name, date|
      #in the future -> countdown
      
      #in the past by more than a day -> countup
      
      beforeOrAfter = "until"
      
      if( (right_now <=> date) == 1)
        beforeOrAfter = "since"
      end
      
      #javascript does 0-based months
      jsMonth = date.mon - 1
      
      elementName = "countDown" + i.to_s
      
      raw_data_html += "\n<tr><td align='left'>" + name.to_s + 
        "</td><td style=\"text-align: right; font-size: 28\"><script type=\"text/javascript\" >\n" +
        "$(function () {  $.countdown.setDefaults({format: 'YODHMS', compact: true});\n  $('#" +elementName + "').countdown({" + beforeOrAfter + ": new Date(" + 
        #date.gsub(" ", "\",\"") +
        date.strftime("\"%Y\", \"" + jsMonth.to_s+"\", \"%d\", \"%H\", \"%M\", \"%S\")") + 
        "}); });</script>\n<div id=\"" + elementName +"\"></div></td></tr>\n"
       i+= 1
    end
    
    @page = Visualizer.build_data_table(@name, raw_data_html) 
    
  end 
end