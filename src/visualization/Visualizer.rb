class Visualizer  
  
  def self.build_data_table(view_name, table_body)     
  return "<table style=\"height: 90%;\" width=\"100%\">\n<thead></thead><tbody>\n#{table_body}\n</tbody></table>\n"
  end
  
  def self.build_header(title)
    
    if(title.length > 40)
      title = title[0..40] + "..."
    end
      
    return '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">' <<
    "\n<html><head id=\"kioskhead\">
    <title class=\"kioskcore\">#{title}</title>
    <META class=\"kioskcore\" http-equiv=Content-Type content=\"text/html; charset=utf-8\">\n
    <link class=\"kioskcore\" rel=\"icon\" href=\"favicon.ico?v=#{rand(1000).to_s}\" type=\"image/x-icon\">
    <link class=\"kioskcore\" rel=\"shortcut icon\" href=\"favicon.ico?v=#{rand(1000).to_s}\" type=\"image/x-icon\">
    
    <script class=\"kioskcore\" type=\"text/javascript\" src=\"js/jquery-1.11.3.min.js\"></script>
    <script class=\"kioskcore\" type=\"text/javascript\" src=\"jquery-ui-1.11.4.custom/jquery-ui.min.js\"></script>
    
    <script class=\"kioskcore\" type=\"text/javascript\" src=\"js/jarvis.kiosk.keybindnav.js\"></script>
    <script class=\"kioskcore\" type=\"text/javascript\" src=\"js/jarvis.marquee.js\"></script>

    <script class=\"kioskcore\" type=\"text/javascript\" src=\"js/jarvis.kiosk.viewUpdater.js\"></script>
    <script class=\"kioskcore\" type=\"text/javascript\" src=\"js/jarvis.kiosk.js\"></script>
    <script class=\"kioskcore\" type=\"text/javascript\" src=\"//cdn.jsdelivr.net/jquery.marquee/1.3.1/jquery.marquee.min.js\"></script>
    <link class=\"kioskcore\" rel=\"stylesheet\" href=\"jquery-ui-1.11.4.custom/jquery-ui.min.css\">
    <link class=\"kioskcore\" rel=\"stylesheet\" href=\"css/progressBar.css\">
    <link class=\"kioskcore\" rel=\"stylesheet\" type=\"text/css\" href=\"css/jquery.countdown.css\">
    <script class=\"kioskcore\" type=\"text/javascript\" src=\"js/jquery.plugin.js\"></script>
    <script class=\"kioskcore\" type=\"text/javascript\" src=\"js/jquery.countdown.min.js\"></script>
    </head>"
  end
  
  def self.build_marquee
    return build_marquee_raw("width: 1500px; overflow: hidden;  border: 1px solid #ccc; background: #FFF;")
  end
  
  def self.build_marquee_raw(config)
    return "<div class=\"kioskcore\" id=\"marq\" style=\"#{config}\"></div>"
  end
  
  def self.build_title_box(text, x, y, width, height, config)
    return self.build_title_box_raw(text, "position:fixed; border:5px solid black; left:#{x}px; top:#{y}px; width:#{width}px; height:#{height}px; #{config};")
  end
  
  def self.build_title_box_raw(text, config)
    return "<div name=\"title\" style=\"#{config}\">#{text}</div>"
  end
  
#  def self.build_update_date_display(update_date)
#    return "<table><tr><td>Last Updated: #{update_date.strftime( "%Y-%m-%d %T")}</td></tr></table>".gsub(' ', '&nbsp;')
#  end
  
  def self.build_kiosk_body
    #this is only returned once, use only static content
    
    return "<body id=\"kioskbody\">
    <div class=\"kioskcore\" id=\"currentViewName\" style=\"display: none;\" ></div>
    <div class=\"kioskcore\" id=\"progress_increment\" style=\"display: none;\" ></div>"
  end
  
  def self.build_transition_prog_bar
    return     "<div class=\"kioskcore\" id=\"transition_area\">
    <table width=\"100%\"><tbody><tr><td width=\"15%\">Last&nbsp;Updated:&nbsp;<div id=\"lastUpdate\"></div></td><td width=\"85%\"><div id=\"progressbar\"></div></td></tr></tbody></table>
    </div>"
  end
  
  def self.build_footer
   return  "
    <div id=\"debug\" class=\"kioskcore\"></div>
    </body></html>"
  end
  
end