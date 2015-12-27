require_relative "../../../../../visualization/Visualizer.rb"

class  KioskInfo < View
  
  def initialize
    
    super
    
    @data = []
    @schema = ["", "Author"]
    @name = "Kiosk Info"
    
    @update_interval = 60000
    @transition_interval = 20
  end
    
  def update_view    
    @data[0] = "JARVIS - Just a Really Viable Information System"
    @data[1] = "Jason Diamond"
  end
   
  def write_page
    raw_data_html = 
    "\n<tr><td width=\"50%\" align='left'><font style=\"font-weight:bold; font-size: 26px\">#{@schema[0]}</font></td><td width=\"50%\" style=\"text-align: right\" ><font style=\"font-weight:bold; font-size: 26px\">#{@data[0].to_s.gsub(' ', '&nbsp;')}</font></td></tr>\n" << 
    "<tr><td width=\"50%\" align='left'><font style=\"font-weight:bold; font-size: 26px\">#{@schema[1]}</font></td><td width=\"50%\" style=\"text-align: right\" ><font style=\"font-weight:bold; font-size: 26px\">#{@data[1].to_s.gsub(' ', '&nbsp;')}</font></td></tr>\n"  

        
    @page = Visualizer.build_title_box("<font style=\"font-weight:bold; font-size: 26px\">Kiosk Info</font>",10,10,170,35,"") << Visualizer.build_data_table(@name, raw_data_html)    
  end
  
end


