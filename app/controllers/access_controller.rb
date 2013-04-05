class AccessController < ApplicationController
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
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
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You are successully logged in"
      redirect_to(:action => menu)
    else
      flash[:notice] = "Invalid Username and password combination"
      redirect_to(:action => 'login')
    end
  end

  def menu
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You have been successfully logged out."
    redirect_to( :action => "login")
  end
end
