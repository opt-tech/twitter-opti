class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.create_twitter_client
    keys = YAML.load_file(File.expand_path("../../../config/twitter_config/twitter_config.yml", __FILE__))
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = keys["api_key"]
      config.consumer_secret = keys["api_secret"]
      config.access_token = keys["access_token"]
      config.access_token_secret = keys["access_token_secret"]
    end
  end

  def self.save_temporary(ids)
    binding.pry
    connection = ActiveRecord::Base.connection
    table_name = "temporaries"
    connection.create_table(table_name, force: true) do |t|
      t.string :duplicate_id
    end

    klass = Class.new(ActiveRecord::Base) do |c|
      c.table_name = table_name
    end
    temporary = Object.const_set(model_name, klass)

    temporaries = []
    ids.each do |id|
      temporaries << temporary.new(duplicate_id: id)
    end
    temporary.import temporaries
  end
end
