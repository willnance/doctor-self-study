class QuestionsController < ApplicationController
  #before_filter :confirm_logged_in
  layout "admin"
  respond_to :json
  
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
    @question = Question.new(:year => @user.year, :rotation => @user.rotation)
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
