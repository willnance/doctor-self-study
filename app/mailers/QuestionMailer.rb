class QuestionMailer < ActionMailer::Base
  default :from => "doctorselfstudy@gmail.com"
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
