class UsersController < ApplicationController
  layout "admin"
  def index
    list
    render('list')
  end
  
  def list
    @Users = User.order("Users.year ASC")
  end
  
  def show
    @User = User.find(params[:id])
  end
  def new
    @User = User.new
  end
  def create
    @User = User.new(params[:User])
    if @User.save
      flash[:notice] = "User created Successfully"
      redirect_to(:action => 'list')
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
    redirect_to(:action => 'list')
  end
end
