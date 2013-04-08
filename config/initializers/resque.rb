require 'resque_scheduler'
ENV["REDISTOGO_URL"] ||= "redis://redistogo:f95d214230c8ec72a902bbd2b519dbe3@spinyfin.redistogo.com:9192/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }


#uncomment to load a yaml file with recurring jobs
#Resque.schedule = YAML.load_file("#{Rails.root}/config/resque_schedule.yml")

require 'resque'
Dir["/app/app/jobs/*.rb"].each { |file| require file }
#added to try to support heroku / resque. Not sure what this does . . .
require 'resque/server'
if Rails.application.config.respond_to? :redis_address
  Resque.redis = Rails.application.config.redis_address
end
