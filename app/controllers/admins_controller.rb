class AdminsController < ApplicationController
  before_filter :confirm_logged_in
  
  def index
    list
    render('list')
  end
  
  def list
    @Admins = Admin.order("Admins.firstName ASC")
  end
  
  def show
    @Admin = Admin.find(params[:id])
  end
  def new
    @Admin = Admin.new
  end
  def create
    @Admin = Admin.new(params[:Admin])
    if @Admin.save
      flash[:notice] = "Admin created Successfully"
      redirect_to(:action => 'list')
    else
      render('new')
    end
    
  end
  def edit
    @Admin = Admin.find(params[:id])
  end
  def update
    @Admin = Admin.find(params[:id])
    @Admin.update_attributes(params[:Admin])
    if @Admin.save
      flash[:notice] = "Admin updated Successfully"
      redirect_to(:action => 'show', :id => @Admin.id)
    else
      render('edit')
    end
  end
  def delete
    @Admin = Admin.find(params[:id])
  end
  def destroy
    @Admin = Admin.find(params[:id])
    @Admin.destroy
    flash[:notice] = "Admin destroyed Successfully"
    redirect_to(:action => 'list')
  end
end


