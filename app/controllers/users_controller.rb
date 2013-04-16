#authors Will Nance and Sanket Prabhu
class UsersController < ApplicationController
  before_filter :confirm_admin , :except => [:show]
  layout "admin"
  
  
  
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
    @Users = User.order("Users.year ASC")
    respond_to do |format| 
      format.html 
      format.json {render(  :json => @Users)}
    end
  end
#  def list
#    @Users = User.order("Users.year ASC")
#  end
  
  def show
    @User = User.find(params[:id])
    respond_to do |format| 
      format.html 
      format.json {render(  :json => @User)}
    end
  end
  def new
    @User = User.new
  end
  def create
    @User = User.new(params[:User])
    if @User.save
      flash[:notice] = "User created Successfully"
      redirect_to(:action => 'index')
    else
      render('new')
    end   
  end
  def edit
    @User = User.find(params[:id])
  end
  def update
    @User = User.find(params[:id])
    @User.update_attributes(params[:User])
    if @User.save
      flash[:notice] = "User updated Successfully"
      redirect_to(:action => 'show', :id => @User.id)
    else
      render('edit')
    end
  end
  def delete
    @User = User.find(params[:id])
  end
  def destroy
    @User = User.find(params[:id])
    @User.destroy
    flash[:notice] = "User destroyed Successfully"
    redirect_to(users_path)
  end
end
