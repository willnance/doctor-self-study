#authors Will Nance and Sanket Prabhu
require "scheduler_job"
#ALL jobs and models must extend the Autoscaling module for cheap Heroku deployment
require 'heroku_resque_auto_scale'


# This represents a link between a question and a user. 
# Since a single question can be assigned to multiple users,
# we use this as an intermediary object that stores information
# about the relationship between a user and a question, such as
# the user's response to the question, whether it was correct, 
# whether the user has submitted a response to the question at all,
# and whether or not his response was blank, as well as the DB id's of the 
# user and question which this object links.
#
class Assignment < ActiveRecord::Base 
  extend HerokuAutoScaler::AutoScaling
  belongs_to :user
  belongs_to :question
  attr_accessible :title, :body, :user_id, :question_id , :response , :correct
  after_create :queue_assignments
  
  #dont want null references floating about
  before_destroy :remove_from_queue
  
  
  #called after a user submits the response
  def grade
    #only grade if they've responded
    if self.responded = true
      self.correct = (response == self.question.solution) 
    end
  end
  
  
  #This throws the assignment into the delayed queue to be pushed out later.
  #as of now this is not working for some very strange back end bug that we cant figure out.
  def queue_assignments
    Resque.enqueue_at(self.question.schedule , SchedulerJob , {:assignment_id => 155})
  end
  
  ## you should remove these assignments if you are about to destroy them.
  #use this method to do so.
  def remove_from_queue
    Resque.remove_delayed(SchedulerJob, :id => self.id)
  end
  
  # call to the Mailer to send an email with 
  # a link to the question.
  def sendAlertEmail
    QuestionMailer.question(self)
  end
  
  # old. Worthless. Teammate quit. This was related to the 
  # JSON rest API for communicating with the iphone.
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
