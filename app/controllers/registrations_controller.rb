class RegistrationsController < ApplicationController 
    def new
        @user = User.new 
    end 

    def create 
        @user=User.new(user_params)
        if User.email_registered?(@user.email)
            redirect_to sign_up_path, alert: "#{user_params[:email]} has already been registered " and return 
        elsif user_params[:password] != user_params[:password_confirmation]
            @user.errors.add(:base, "Password do not match")
            render :new
        elsif @user.save 
            session[:user_id] = @user.id
            redirect_to new_wallet_path, notice: "Successfully created account!"
        else 
            render :new
        end 
    end 

    private 

    def user_params
        params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
    end 
end
