require './Jarvis.rb'
require './config/Loader.rb'


loader = Loader.new("../conf/praxis.json")

#load services/jobs 
#eval "use #{s2}, message: s2, i: 2"
#eval "use #{s3}, message: s3, i: 3"


services = loader.get_services_config()
services.each do |service, config|
  
  puts "Launching service #{service} with config #{config}"
  
  eval "use #{service}, config: config"
  
end

#load jobs
jobs = loader.get_jobs_config()
jobs.each do |job|  
  job.start
end



puts "====================="
run Sinatra::Application