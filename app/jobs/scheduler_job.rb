#authors Will Nance and Sanket Prabhu
#ALL jobs and models must extend the Autoscaling module for cheap Heroku deployment
require 'heroku_resque_auto_scale'
class SchedulerJob 
  extend HerokuAutoScaler::AutoScaling
  
  
  
  
  #I cant get this stupid thing to work!!!!!!!
  #
  #This is the simplest of jobs. This perform method gets automatically called when 
  #resque pops off a job. Resque isnt working though and it's generating wonky SQL that breaks the system.
  #No idea why it does this and apparently no one else does either. 
  #See this stackoverflow post for more details:
  #http://stackoverflow.com/questions/15858776/mysql-error-using-resque-with-rails-table-does-not-exist
  @queue = :default_queue
  def self.perform(assignment_id)
    assignment = Assignment.find_by_id(assignment_id)
    assignment.sendAlertEmail
  end
end
