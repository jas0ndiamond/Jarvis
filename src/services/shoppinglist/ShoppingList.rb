require_relative "../../services/Service.rb"
require 'json'

class ShoppingList < Service
  
  @@webdir = "shoppinglist"
  
  #  "section":{
  #    "section item":[
  #      "item 1",
  #      "item 2"
  #      ]

  def initialize(app = nil, params = {})
      
      super
      
      config = params.fetch(:config, false)
      
      logfile = config["logfile"] unless !config["logfile"]
      logfile = '../logs/keepalive.log' unless logfile
      
      $logger = Logger.new(logfile, 0, 10 * 1024 * 1024) 
      
      @file = config["file"] unless !config["file"]
        
      
  end
      
  get "/#{@@webdir}" do
    #return rendered page
    shopping_list = ""
    File.open(@file, "r") do |f|
      f.each_line do |line|
        shopping_list << line
      end
    end
    
    json_shopping_list = JSON.parse(shopping_list)
    
    ##local resources -> need ../ prefix since we're in a /shoppinglist/ dir
    output = "<html><head><title>Shopping List</title><meta charset=\"utf-8\">" << 
    "<link rel=\"stylesheet\" href=\"jquery-ui-1.11.4.custom/jquery-ui.min.css\">\n" <<
    "<script type=\"text/javascript\" src=\"js/jquery-1.11.3.min.js\"></script>\n" <<
    "<script type=\"text/javascript\" src=\"jquery-ui-1.11.4.custom/jquery-ui.min.js\"></script>\n" <<
    "</head>\n<body>\n<div id=\"tabs\">\n<ul>\n"
    
    tab_num=0
    json_shopping_list.keys.each do |section|
      output << "<li><a href=\"#fragment-#{tab_num}\"><span>#{section}</span></a></li>\n"
      tab_num+=1
    end
    
    output << "</ul>\n"
    
    tab_num=0
    json_shopping_list.each do |section,sub_section|
      output << "<div id=\"fragment-#{tab_num}\">\n"      
      output << "<ul>\n"
      sub_section.each do |item,notes|
        output<< "<input type=\"checkbox\"><b>#{item}</b></input><br>\n<ul>\n"
        
        notes.each do |note|
          output << "<input type=\"checkbox\">#{note}</input><br>\n"
        end
        
        output << "</ul>"
      end
      output << "</ul>\n"
      output << "</div>\n"
      tab_num+=1
    end
    
    output<<"</div>\n"
    
    return output << "\n\n<script>\n$( \"#tabs\" ).tabs();\n</script>\n</body></html>"
  end
  
  get "/#{@@webdir}/edit" do
    #access control
    
    #load editable interface
    
    #pour interface fields into json
    #pour results back into file
  end
  
end
  


