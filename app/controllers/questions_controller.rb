#authors Will Nance and Sanket Prabhu
class QuestionsController < ApplicationController
  
  before_filter :confirm_admin
  layout "admin"
  respond_to :json
  
  #This is a basic controller. nothing fancy here
  #There is functionality for the CRUD actions here
  # with the typical 8 Rails methods
  # list (index) & show, new & create , edit & update , and delete & destroy
  # Look at basic rails documentation to understand this. 
  # 
  # Also note there is some JSON functionality built into this.
  # Again this is a legacy feature from when we were going to support
  # an iOS REST API. If you need it its there and easy to configure.
  
  
  
  
  def index
    @questions = Question.order("id ASC")    
    respond_to do |format| 
      format.html 
      format.json {render(  :json => @questions)}
    end
  end
  
#  def list
#    @questions = Question.order("questions.position ASC")
#    
#    #respond_with @questions
#  end
  
  def show
    @question = Question.find(params[:id])
    respond_to do |format| 
      format.html 
      format.json {render(  :json => @question)}
    end
  end
  def new
    @user = User.find_by_id(params[:user_id]) if params[:user_id]
    @question = Question.new()
  end
  def create
    @question = Question.new(params[:question])
    if @question.save
      flash[:notice] = "Question created Successfully"
      redirect_to(questions_path)
    else
      render('new')
    end
    
  end
  def edit
    @question = Question.find(params[:id])
  end
  def update
    @question = Question.find(params[:id])
    @question.update_attributes(params[:question])
    if @question.save
      flash[:notice] = "question updated Successfully"
      redirect_to(:action => 'show', :id => @question.id)
    else
      render('edit')
    end
  end
  def delete
    @question = Question.find(params[:id])
  end
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:notice] = "Question destroyed Successfully"
    redirect_to(questions_path)
  end
  
  
  
  
end
