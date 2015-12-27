require_relative "../../../../../visualization/Visualizer.rb"

require "feedjira"

class Feed < View
  
  attr_accessor :sourceURL
  
  def initialize(name, sourceURL)
    
    super()
    
    @sourceURL = sourceURL
    @name = name
    @data = Array.new
    
    @schema = ["Date", "Title", "Description"]
      
    @update_interval = 60
    @transition_interval = 90
  end
  
  def update_view

    @data.clear

    max_size = 10

    feed = Feedjira::Feed.fetch_and_parse(@sourceURL)

    #some feeds are encoded incorrectly or malformed.
    return if feed == nil
    #return if feed == 200
    return if feed.entries == nil
    
    feed.entries.each do |entry|
      @data.push( entry )
    end

    #some feeds don't have their entries sorted by date. resolve that here
    @data.sort! {|a,b| b.published <=> a.published }

    @data.pop until @data.size() <= max_size

  end
  
  def write_page; 
    feed_html = ""
      
      @data.each do |entry|
        
        #only want date and hh:mm. seconds aren't too vital in most rss feeds
        entry_pub_date = entry.published.in_time_zone('America/New_York').to_s.split(" ")[0,2].join(" ")[5..-1][0..-4].gsub(' ', '&nbsp;')
        entry_title = entry.title
        
        if(entry_title.length > 90)
          entry_title = entry_title[0..90] + "..."
        end
        
          feed_html <<
          "<tr><td style=\"width: 1280px;\"><font style=\"font-weight:bold; font-size: 26px\">#{entry_title.to_s.gsub(' ', '&nbsp;')}</font><font style=\"font-size: 16px\">" +"&nbsp;-&nbsp;#{ entry_pub_date}</font></td></tr>\n"
      end
        
    #pointless to show links, just really titles and dates
    
    #check if there is a picture or icon and draw appropriately
    #most recent n items
    @page = Visualizer.build_data_table(@name, feed_html)    
    
  end     
  
end

