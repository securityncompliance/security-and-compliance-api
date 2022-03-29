require_relative 'aws_secrets_manager.rb'

class SecretsManager
  def self.get_secrets(provider = ::AwsSecretsManager)
    provider.get_secrets
  end
end