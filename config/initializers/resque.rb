#authors Will Nance and Sanket Prabhu , with lots of help from the internet


require 'resque_scheduler'
require 'resque/server'

#redistogo.com
#username / email wllnance@gmail.com CHANGEME
#password doctorselfstudy
ENV["REDISTOGO_URL"] ||= "redis://redistogo:f95d214230c8ec72a902bbd2b519dbe3@spinyfin.redistogo.com:9192/"


require 'resque'
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)




