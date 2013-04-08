class AssignmentsController < ApplicationController
  before_filter :store_location
  #before_filter  :confirm_admin , :except => [:show, :edit]
  before_filter :confirm_logged_in ,:only =>[:respond]
  
  layout 'admin'
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
  #  def confirm_logged_in
  #    unless session[:user_id]
  #      return false
  #    else 
  #      return true  
  #    end
  #  end
  
  #display a pre-answer page that gives instructions to the user and a link to the answer page
  #user must be logged in, but not necessarily an admin
  def show
    @assignment = Assignment.find_by_id(params[:id])
    @user = @assignment.user 
    @admin = Admin.find_by_id(session[:user_id]) if session[:admin]
    
    @question = @assignment.question
    
  end
  
  def edit
    @assignment = Assignment.find_by_id(params[:id])
    @user =     @assignment.user
    @question = @assignment.question
    puts "user #{@user} question #{@question} assignment #{@assignment}"
  end
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
  def feedback
    @assignment = Assignment.find_by_id(params[:id])
    @user = @assignment.user
  end
  def respond
     @assignment = Assignment.find_by_id(params[:id])
    @user =     @assignment.user
    @question = @assignment.question
    puts "user #{@user} question #{@question} assignment #{@assignment}"
  end
  
end
