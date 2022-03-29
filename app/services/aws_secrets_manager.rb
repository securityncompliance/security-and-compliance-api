require 'aws-sdk-secretsmanager'

class AwsSecretsManager
	def self.get_secrets(secret_name = 'prod/db_connection_string', region_name = 'us-east-1')
    client = Aws::SecretsManager::Client.new(region: region_name)

    # In this sample we only handle the specific exceptions for the 'GetSecretValue' API.
    # See https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_GetSecretValue.html
    # We rethrow the exception by default.
    begin
      get_secret_value_response = client.get_secret_value(secret_id: secret_name)
    rescue Aws::SecretsManager::Errors::DecryptionFailure => e
      # Secrets Manager can't decrypt the protected secret text using the provided KMS key.
      # Deal with the exception here, and/or rethrow at your discretion.
      raise
    rescue Aws::SecretsManager::Errors::InternalServiceError => e
      # An error occurred on the server side.
      # Deal with the exception here, and/or rethrow at your discretion.
      raise
    rescue Aws::SecretsManager::Errors::InvalidParameterException => e
      # You provided an invalid value for a parameter.
      # Deal with the exception here, and/or rethrow at your discretion.
      raise
    rescue Aws::SecretsManager::Errors::InvalidRequestException => e
      # You provided a parameter value that is not valid for the current state of the resource.
      # Deal with the exception here, and/or rethrow at your discretion.
      raise
    rescue Aws::SecretsManager::Errors::ResourceNotFoundException => e
      # We can't find the resource that you asked for.
      # Deal with the exception here, and/or rethrow at your discretion.
      raise
    else
      # This block is ran if there were no exceptions.
      get_secret_value_response.secret_string
    end
	end
end
