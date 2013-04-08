#ALL jobs and models must extend the Autoscaling module for cheap Heroku deployment
require 'heroku_resque_auto_scale'
class SchedulerJob 
  extend HerokuAutoScaler::AutoScaling
  @queue = :default_queue
  def self.perform(assignment_id)
    @assignment=Assignment.find_by_id(assignment_id)
    @assignment.sendAlertEmail
  end
end
