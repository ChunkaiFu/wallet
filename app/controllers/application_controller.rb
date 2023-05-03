class ApplicationController < ActionController::Base
before_action :set_current_user
protect_from_forgery with: :exception

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end 

  def login_path
    '/sign_in'
  end  

  def require_user_logged_in!
    redirect_to sign_in_path, alert: "You must sign in to do that." if Current.user.nil? 
  end

  private

  def authenticate_admin_user!
    redirect_to new_admin_session_path unless session[:admin_authenticated]
  end

  def current_admin_user
    @current_admin_user ||= User.find_by(id: session[:admin_user_id])
  end


end
