class AccessController < ApplicationController
  before_filter :confirm_admin, :except => [:login, :attempt_login, :logout]
  layout "admin" , :except =>:login
  def index
    menu
    render("menu")
  end
  def login
    
  end

  def attempt_login
    authorized_user = Admin.authenticate(params[:username], params[:password])
    if authorized_user
      session_login(authorized_user,true) 
      flash[:notice] = "You are successully logged in with administrator priveliges"
      redirect_back_or_default
    
#      if (params[:assignment_id] == nil) #or( Assignment.find_by id(params[:assignment_id]) == nil)
#        puts "assignment id in the parameters"
#        puts params[:assignment_id]
#        redirect_to(:action => "menu")
#      else
#        assignment = Assignment.find_by_id(params[:assignment_id])
#        redirect_to(url_for(assignment.user, assignment , :html=>{:method => :get} ))
#      end
      
    else
      authorized_user = User.authenticate(params[:username], params[:password])
      if authorized_user
        session_login(authorized_user ,false)
        flash[:notice] = "You are successully logged in"
        puts "successfully logged in"
        redirect_back_or_default
#        if (params[:assignment_id] == nil) or( Assignment.find_by id(params[:assignment_id]) == nil)
#          redirect_to(:controller => 'users' , :action => 'show')
#        else
#          redirect_to(url_for(authorized_user, Assignment.find_by_id( params[:assignment_id]) , :html=>{:method => :get} ))
#        end
      else
        flash[:notice] = "Invalid Username and password combination"
        redirect_to(:action => 'login')
      end
    end
  end

  
  def session_login(authorized_user , is_admin = false)
    session[:user_id] = authorized_user.id
    session[:username] = authorized_user.username
    session[:admin] = is_admin
  end

  def menu
  end
  
  def logout
    session[:user_id] = nil
    session[:username] = nil
    session[:admin] = false
    flash[:notice] = "You have been successfully logged out."
    redirect_to( :action => "login")
  end
end
