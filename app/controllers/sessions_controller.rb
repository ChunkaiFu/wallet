class SessionsController < ApplicationController
  def new 
    render
  end 

  def create 
    user = User.find_by(email: params[:email])
    if user.present? 
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        if user.kyc.present?  
          if user.kyc.status == "pending"
            redirect_to kyc_new_path, notice: "Logged in successfully!"
          elsif user.kyc.status == "awaiting"
            redirect_to kyc_show_path
          end
        else
          redirect_to root_path
        end
      end  
    else 
      flash[:alert] = "Invalid email or password!"
      render :new
    end 
  end 

  def destroy 
    session[:user_id] = nil 
    redirect_to root_path, notice: "Logged out"
  end 

  def omniauth
    auth = request.env['omniauth.auth'][:info]
    user = User.find_by(email: auth[:email])
    random_password = SecureRandom.hex(10)

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed in! Please remember to change your password! "
    else
      new_user = User.new(
        email: auth[:email], 
        firstname: auth[:first_name], 
        lastname: auth[:last_name], 
        password: random_password, 
        password_confirmation: random_password
        )
      if new_user.save
        session[:user_id] = new_user.id
        redirect_to terms_path, alert: "please accept our terms of use!"
      else
        redirect_to sign_up_path, alert: "Unable to create account, please try again"
      end
    end 
  end 
end 
