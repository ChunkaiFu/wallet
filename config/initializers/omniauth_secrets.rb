require 'aws-sdk-secretsmanager'
require 'json'

def get_secret(secret_id)
  credentials = Aws::Credentials.new(
    # set the key and secret for my AWS account to access the resources like secrets in 
    ENV['AWS_KEY'], 
    ENV['AWS_SECRET']
    )

  client = Aws::SecretsManager::Client.new(region: 'us-east-2', credentials: credentials)
  begin
    get_secret_value_response = client.get_secret_value(secret_id: secret_id)
  rescue StandardError => e
    raise e
  end
  secret_raw = get_secret_value_response.secret_string
end