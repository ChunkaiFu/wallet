require 'aws-sdk-secretsmanager'
require 'json'

def get_secret(secret_id)
  credentials = Aws::Credentials.new(Rails.application.credentials.dig(:aws, :AWS_KEY), Rails.application.credentials.dig(:aws, :AWS_SECRET))
  client = Aws::SecretsManager::Client.new(region: 'us-east-2', credentials: credentials)
  begin
    get_secret_value_response = client.get_secret_value(secret_id: secret_id)
  rescue StandardError => e
    raise e
  end
  secret_raw = get_secret_value_response.secret_string
end