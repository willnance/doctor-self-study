#authors Will Nance and Sanket Prabhu
class AccessController < ApplicationController
  before_filter :confirm_admin, :except => [:login, :attempt_login, :logout]
  #cant be logged in on the login screen :-p
  layout "admin" , :except =>:login
  
  
  #default access action
  #you should just render 
  #the menu view
  def index
    menu
    render("menu")
  end
  
  
  #nothing to set up here just render the 
  #form for username and password
  def login
    
  end

  
  #take the input from the form ans see if you 
  #can find a user or admin with those credentials
  #if not go back to login page and let them try again
  def attempt_login
    #first see if it's an admin
    authorized_user = Admin.authenticate(params[:username], params[:password])
    if authorized_user
      session_login(authorized_user,true) 
      flash[:notice] = "You are successully logged in with administrator priveliges"
      redirect_back_or_default      
    else
      #try to see if its a user
      authorized_user = User.authenticate(params[:username], params[:password])
      if authorized_user
        session_login(authorized_user ,false)
        flash[:notice] = "You are successully logged in"
        puts "successfully logged in"
        redirect_back_or_default
      else
        flash[:notice] = "Invalid Username and password combination"
        redirect_to(:action => 'login')
      end
    end
  end

  #edit the session file to mark the user as logged in
  def session_login(authorized_user , is_admin = false)
    session[:user_id] = authorized_user.id
    session[:username] = authorized_user.username
    session[:admin] = is_admin
  end

  #nothing to set up just render the menu view
  def menu
  end
  
  #kill all the session file entries
  #so you wont be logged in anymore
  def logout
    session[:user_id] = nil
    session[:username] = nil
    session[:admin] = false
    session[:return_to] = nil
    flash[:notice] = "You have been successfully logged out."
    redirect_to( :action => "login")
  end
end
