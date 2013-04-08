require "scheduler_job"
#ALL jobs and models must extend the Autoscaling module for cheap Heroku deployment
require 'heroku_resque_auto_scale'
class Assignment < ActiveRecord::Base 
  extend HerokuAutoScaler::AutoScaling
  belongs_to :user
  belongs_to :question
  attr_accessible :title, :body, :user_id, :question_id , :response , :correct
  after_create :queue_assignments
  before_destroy :remove_from_queue
  
  def grade
    self.correct = (response == self.question.solution) unless response == nil
  end
  def queue_assignments
    Resque.enqueue_at(self.question.schedule , SchedulerJob , {:assignment_id => 155})
  end
  def remove_from_queue
    Resque.remove_delayed(SchedulerJob, :id => self.id)
  end
  def sendAlertEmail
    QuestionMailer.question(self)
  end
  def as_json(options={})
    {
      :correct => correct,
      :created_at =>  created_at,
      :id => id, 
      :question_id => question_id,
      :response => response ,
      :updated_at => updated_at,
      :user_id => user_id,
      :question => self.question
    }
  end
end
