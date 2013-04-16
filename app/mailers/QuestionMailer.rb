#authors Will Nance and Sanket Prabhu
class QuestionMailer < ActionMailer::Base
  
  #hardcoded!!!
  default :from => "doctorselfstudy@gmail.com"
  
  #defines the types of emails this application can send. The 
  #ActionMailer behaves very much like a Controller in that the 
  #.html.erb files have access to the state you set here. 
  #note the question method, which is supposed to do the sending 
  #of emails with the link to answer a question. The scheduler_job.rb job
  #is supposed to call this method through the assignment class but
  #we cant get Resque working
def deliver_welcome(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to My Awesome Site").deliver
  end
  
  def question(assignment)
    @user = assignment.user
    @question = assignment.question
    mail(:to => @user.email, :subject => "Welcome to My Awesome Site").deliver
  end

end
