require_relative "../../../../../visualization/Visualizer.rb"

#system info for the pi platform
class SystemInfo < View
  
  def initialize
    super
    
    @data = []
    @schema = ["Load Averages", "Uptime", "LAN IP", "WAN IP", "Hostname"]
    @name =  "System Information"
    
    @update_interval = 5
    @transition_interval = 20
    
    @show_marq = false
  end

  
  def update_view
    @data.clear
    
    #need -s to curl because ruby outputs transfer data
    @data.push(
      `/bin/cat /proc/loadavg  | /usr/bin/awk '{print $1,$2,$3}'`.chomp!(),
      `cat /proc/uptime  | /usr/bin/awk '{print $1}'`.chomp!().to_i()/60/60/24,
      `/sbin/ifconfig | /bin/grep "inet addr" | /usr/bin/awk '{print $2}' | /usr/bin/awk -F \: '{print $2}' | /bin/grep -v 127.0.0.1`.chomp!(),
      `/usr/bin/dig +short myip.opendns.com @resolver1.opendns.com`.chomp!(),
      `/bin/hostname`.chomp!()
    );
  end
   
  def write_page
        
    raw_data_html = 
        "<tr><td align='left'><font style=\"font-weight:bold; font-size: 26px\">#{schema[0]}</font></td><td style=\"text-align: right\" ><font style=\"font-weight:bold; font-size: 26px\">#{data[0].to_s}</font></td></tr>\n" << 
        "<tr><td align='left'><font style=\"font-weight:bold; font-size: 26px\">#{schema[1]}</font></td><td style=\"text-align: right\" ><font style=\"font-weight:bold; font-size: 26px\">#{data[1].to_s} days</font></td></tr>\n" <<
        "<tr><td align='left'><font style=\"font-weight:bold; font-size: 26px\">#{schema[2]}</font></td><td style=\"text-align: right\" ><font style=\"font-weight:bold; font-size: 26px\">#{data[2].to_s}</font></td></tr>\n" <<
        "<tr><td align='left'><font style=\"font-weight:bold; font-size: 26px\">#{schema[3]}</font></td><td style=\"text-align: right\" ><font style=\"font-weight:bold; font-size: 26px\">#{data[3].to_s}</font></td></tr>\n" <<
        "<tr><td align='left'><font style=\"font-weight:bold; font-size: 26px\">#{schema[4]}</font></td><td style=\"text-align: right\" ><font style=\"font-weight:bold; font-size: 26px\">#{data[4].to_s}</font></td></tr>\n" 

    @page = Visualizer.build_title_box("<font style=\"font-weight:bold; font-size: 26px\">System Info</font>",10,10,200,35,"") << "<br>"<< Visualizer.build_data_table(@name, raw_data_html) 
  end
end