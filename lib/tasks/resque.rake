#authors Will Nance and Sanket Prabhu, with help from the internet



require 'resque/tasks'
require 'resque_scheduler/tasks'
require 'resque_scheduler/server'
require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end
task "resque:scheduler_setup" => :environment do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"





