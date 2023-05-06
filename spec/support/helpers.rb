module Helpers
    def simulate_user_login(user)
      session[:user_id] = user.id
    end
  end
  