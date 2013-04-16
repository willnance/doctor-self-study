#authors Will Nance and Sanket Prabhu
class AdminsController < ApplicationController
  before_filter :confirm_logged_in
  layout 'admin'
  
  #display all admins
  def index
    @Admins = Admin.order("Admins.firstName ASC")
  end
  
  
  #Display the information about a single Admin
  def show
    @Admin = Admin.find(params[:id])
  end
  
  
  #set up an empty Admin for the user to fill in.
  def new
    @Admin = Admin.new
  end
  
  
  #take the user's input and create a new Admin from it
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
  
  
  #Find the admin the user is trying to edit 
  #so the user can edit its information
  #display a form to edit that information
  def edit
    @Admin = Admin.find(params[:id])
  end
  
  
  #Take the user's input and update the attributes 
  #then redirect to the list of admins
  def update
    @Admin = Admin.find(params[:id])
    if @Admin.update_attributes(params[:Admin])
      flash[:notice] = "Admin updated Successfully"
      redirect_to(admins_path)
    else
      render('edit')
    end
  end
  
  
  #find the admin that the user is trying to delete
  #render a page where it asks you if youre sure 
  #you want to delete the admin
  def delete
    @Admin = Admin.find(params[:id])
  end
  
  
  #the user is sure so delete that admin for good!
  def destroy
    @Admin = Admin.find(params[:id])
    @Admin.destroy
    flash[:notice] = "Admin destroyed Successfully"
    redirect_to(admins_path)
  end
  
  
end


