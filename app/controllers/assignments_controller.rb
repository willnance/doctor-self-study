
#authors Will Nance and Sanket Prabhu
class AssignmentsController < ApplicationController
  before_filter :store_location, :only => [:respond]
  #before_filter  :confirm_admin , :except => [:show, :edit]
  before_filter :confirm_logged_in ,:only =>[:respond]
  
  layout 'admin'
  
  #list all assignments for a particular user. 
  #if no user is selected, then list all without duplicates
  def index
    @assignments = Assignment.order("id asc")
    unless params[:user_id] == nil
      @user = User.find_by_id(params[:user_id])
      @assignments = User.find_by_id(params[:user_id]).assignments 
    end
    @questions = []
    @assignments.each do |assign|
      question = Question.find_by_id(assign.question_id)
      @questions << question if ! @questions.include?(question)
    end
    respond_to do |format| 
      format.html 
      format.json {render(:json => @questions)}
    end
  end
  
  
  #display a pre-answer page that gives instructions to the user and a link to the answer page
  #user must be logged in, but not necessarily an admin
  def show
    @assignment = Assignment.find_by_id(params[:id])
    @user = @assignment.user 
    @admin = Admin.find_by_id(session[:user_id]) if session[:admin]
    
    @question = @assignment.question
    
  end
  
  #this doesnt really get called but it kind of makes sense to edit the question 
  #associated with this assignment so i put the functionality here anyway
  def edit
    @assignment = Assignment.find_by_id(params[:id])
    @user =     @assignment.user
    @question = @assignment.question
    puts "user #{@user} question #{@question} assignment #{@assignment}"
  end
  
  #Take the users response and save it to the assignment 
  #Hope that it doesnt fail . . .
  def grade
    @assignment = Assignment.find(params[:id])
    @user = @assignment.user
    @assignment.update_attributes(:response => params[:response])
    @assignment.grade
    if @assignment.save
      flash[:notice] = "Your response has been saved"
      redirect_to(:action => 'feedback', :id => @assignment.id , :user_id => @user.id)
    else
      puts @assignment.save
      puts "could not save"
      render(user_assignment_path(@user, @assignment) , :html => {:method => :get})
    end
  end
  
  #This was leftover from when we were using REST methods in our app. When 
  #the iOS  developer quit, we didnt need it anymore. I think is should still
  #work (its the same as grade) but you dont want to call it unless you switch
  #back to using a REST API with an iPhone. In that case, this would get called 
  #automatically for an HTTP put request.I think you can probably dig around
  #and find a way to map that rest path to the grade action but you're on your 
  #own for that
  #
  def update
    puts "params " + params[:id]
    @assignment = Assignment.find(params[:id])
    @user = @assignment.user
    @assignment.update_attributes(:response => params[:assignment][:response])
    @assignment.grade
    if @assignment.save
      flash[:notice] = "Your response has been saved"
      redirect_to(:action => 'show', :id => @assignment.id , :user_id => @user.id)
    else
      puts @assignment.save
      puts "could not save"
      render(user_assignment_path(@user, @assignment) , :html => {:method => :get})
    end
  end
  
  
  #set up the state for the feedback page. the feedback page is hideous right now. 
  #you should edit feedback.html.erb to make it prettier. Currently it just responds with 
  #whether or not the user answered correctly or not.
  ##
  def feedback
    @assignment = Assignment.find_by_id(params[:id])
    @user = @assignment.user
  end
  
  
  #set up the state for  the respond page
  #This takes you to the page where the user
  #can submit a response to the multiple choice question
  #
  def respond
    @assignment = Assignment.find_by_id(params[:id])
    @user =     @assignment.user
    @question = @assignment.question
    puts "user #{@user} question #{@question} assignment #{@assignment}"
  end
  
end
