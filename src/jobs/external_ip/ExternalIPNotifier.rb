require_relative "../../mail/Mailer.rb"
require_relative "../Job.rb"

require 'json'

class ExternalIPNotifier < Job

  #update mailing list with external ip
    
  attr_accessor :logger
  
  def initialize(config)
    super()
    
    logfile = config["logfile"] unless !config["logfile"]
    logfile = '../logs/externalip.log' unless logfile
    $logger = Logger.new(logfile, 0, 10 * 1024 * 1024) 
    
    @config = config
    
    @cache_file = "../tmp/wanip"
      
    $logger.info "Start External IP Notifier"
  end
  
  def run
    
    cached_ip = File.read(@cache_file) unless !File.exists?(@cache_file)
    cached_ip = nil unless cached_ip =~ /\b(?:\d{1,3}\.){3}\d{1,3}\b/
    
    #get the current ip
    external_ip = get_wan_ip
    
    if( !cached_ip or external_ip != cached_ip )
       
      #alert the people
      $logger.info("Found new ip: #{external_ip}")
      

      
      begin
        
        @config['mailing_list'].each do |dest|
        
#Preserve this formating          
        @config["message"] =<<EOF
To: <#{dest}>
From: IP Address Updater  <#{@config['smtp_user']}>
Subject: IP Address Update

Your new WAN IP is: #{external_ip}
EOF
#EOF can't have whitespace after it     
      
      
          Mailer.send_mail(external_ip, @config)
                
        end
        #overwrite cached ip
        File.open(@cache_file, 'w') {|f| f.write external_ip }
      rescue Exception => e
         puts "Error sending update: " + e.message
      end
    end
  
  end
  
  def get_wan_ip
    external_ip = `/usr/bin/dig +short myip.opendns.com @resolver1.opendns.com`
    external_ip.chomp!
    
    return external_ip
  end

end
