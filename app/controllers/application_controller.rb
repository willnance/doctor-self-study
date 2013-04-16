#authors Will Nance and Sanket Prabhu
class ApplicationController < ActionController::Base
 
  protect_from_forgery
  protected
  #confirm the current user is a lease a valid user, not necessarily admin
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please Log In."
      store_location
      redirect_to(:controller => 'access',  :action => 'login')
      return false
    else 
      return true  
    end
  end
  #confirm that a user is logged in and is an admin 
  def confirm_admin
    puts "this is the session admin #{session[:admin]}"
    unless session[:admin]
      
      flash[:notice] = "You need Administrator Priveleges to view this page"
      store_location
      redirect_to(:controller => 'access',  :action => 'login')
      return false
    else 
      return true  
    end
  end
  
  #utility method to store the last location
  #works in conjunction with redirect to back or default.
  #use filters in the controller to call this before 
  #an action that requires login(see assignments 
  #controller for example)
  def store_location
    session[:return_to] =
      if request.get?
      request.url
    else
      request.referer
    end
  end
  
#utility method that checks to see if there is a return to location in the session
#if so it goes thee, else is just goes to main menu
#I got this off the internet so I don't realy get the syntax . . .ruby fluff
#It destroys the return to location so other calls to this method will work correctly
  def redirect_back_or_default(default = '/')
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
