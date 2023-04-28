class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    if params[:email] == 'admin@example.com' && params[:password] == 'password'
      session[:admin_authenticated] = true
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

  def edit
    @kyc = Kyc.find(params[:id])
    @user = @kyc.user
    render 
  end

  def update
    @kyc = Kyc.find(params[:id])
    if(session[:admin_authenticated])
      if @kyc.update(kyc_params)
        redirect_to admin_dashboard_path, notice: "KYC status updated successfully."
      else
        redirect_to admin_sessions_path(@kyc), alert: "Failed to update KYC status."
      end
    end
  end
  private
  def sessions_params
    params.require(:kyc).permit(:status)
  end

end
