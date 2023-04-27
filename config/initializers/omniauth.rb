Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :google_oauth2, JSON.parse(get_secret('google_client_id'))["GOOGLE_CLIENT_ID"], JSON.parse(get_secret('google_client_secret'))["GOOGLE_CLIENT_SECRET"]
end 

OmniAuth.config.allowed_request_methods = [:post, :get]

