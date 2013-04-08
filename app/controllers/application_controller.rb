
class ApplicationController < ActionController::Base
 
  protect_from_forgery
  protected
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
  
  
  def store_location
  session[:return_to] =
  if request.get?
    request.url
  else
    request.referer
  end
end

  def redirect_back_or_default(default = 'access/menu')
  redirect_to(session[:return_to] || default)
  session[:return_to] = nil
end

end
