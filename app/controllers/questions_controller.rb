class QuestionsController < ApplicationController
  
  
  
  def index
    list
    render('list')
  end
  
  def list
    @questions = Question.order("questions.position ASC")
  end
  
  def show
    @question = Question.find(params[:id])
  end
  def new
    @question = Question.new
  end
  def create
    @question = Question.new(params[:question])
    if @question.save
      flash[:notice] = "Question created Successfully"
      redirect_to(:action => 'list')
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
    redirect_to(:action => 'list')
  end
  
  
  
  
end
