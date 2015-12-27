require_relative "../../../../../visualization/Visualizer.rb"

class WebsiteFeed < View
  
  attr_accessor :target_url
  
  def initialize(name, target_url, x_dim, y_dim)

    super()
    
    @name = name 
    @target_url = target_url
    
    @x_dim = x_dim
    @y_dim = y_dim
    
    @update_interval = 1
    @transition_interval = 30
  end
  
  def update_view; end
     
  def write_page
    stream = '<tr><td align="center" valign="center"  width="' + @x_dim.to_s + '"><iframe id="' + @name.to_s + '" align="center" src="' + @target_url.to_s + '" width="' + (@x_dim + 30).to_s + '" height="' + (@y_dim+30).to_s + '"></iframe></td></tr>'    
    @page = Visualizer.build_data_table(@name, stream)    
  end
end