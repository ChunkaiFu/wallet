class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    if params[:email] == 'admin@example.com' && params[:password] == 'password'
      session[:admin_authenticated] = true
      puts("admin login success")
      flash.now[:alert] = 'Admin login successful'
      redirect_to admin_dashboard_path
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session[:admin_authenticated] = false
    redirect_to root_path
  end
end
