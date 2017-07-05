class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.create_twitter_client
    keys = YAML.load_file(File.expand_path("../../../config/twitter_config.yml", __FILE__))
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = keys["api_key"]
      config.consumer_secret = keys["api_secret"]
      config.access_token = keys["access_token"]
      config.access_token_secret = keys["access_token_secret"]
    end
  end
end
