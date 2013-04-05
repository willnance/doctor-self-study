class AssignmentsController < ApplicationController
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
      format.json {render(  :json => @questions)}
    end
  end
end
