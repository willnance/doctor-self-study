class AdminsController < ApplicationController
  before_filter :confirm_logged_in
  layout 'admin'
  def index
    @Admins = Admin.order("Admins.firstName ASC")
  end
  
#  def list
#    
#  end
  
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
      redirect_to(:action => 'show', :id => @Admin.id)
    else
      flash[:notice] = "an error occurred"
      render('new')
    end
    
  end
  def edit
    @Admin = Admin.find(params[:id])
  end
  def update
    @Admin = Admin.find(params[:id])
    if @Admin.update_attributes(params[:Admin])
      flash[:notice] = "Admin updated Successfully"
      redirect_to(admins_path)
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
    redirect_to(admins_path)
  end
end


