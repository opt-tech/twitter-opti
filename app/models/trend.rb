class Trend < ApplicationRecord
  require 'json'
  require 'oauth'

  def self.get_trend
    @client = self.create_twitter_client
    consumer = OAuth::Consumer.new(
      @client.consumer_key,
      @client.consumer_secret,
      {
        :site   => 'http://api.twitter.com',
        :scheme => :header
      }
    )
    token_hash = {
      :access_token        => @client.access_token,
      :access_token_secret => @client.access_token_secret
    }
    # Twitterへのリクエストトークン作成
    request_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    woeids_hash = YAML.load_file(File.expand_path("../../../config/woeid.yml", __FILE__))
    trends = []
    # 各woeidを回してトレンドを取得し、ハッシュに詰める
    woeids_hash.values.each do |hash|
      woeid = hash.values.first
      region = hash.keys.first
      response_place = request_token.request(:get, "https://api.twitter.com/1.1/trends/place.json?id=#{woeid}")
      japan_trends = JSON.parse(response_place.body)
      japan_trends[0]['trends'].each do |trend|
        trends << Trend.new(region:region, trend_word:trend['name'])
      end
    end
    Trend.import trends
  end

  def self.get_disp_trend(latest_two_created_at)
    woeids_hash = YAML.load_file(File.expand_path("../../../config/woeid.yml", __FILE__))

    trend_hash = {}
    woeids_hash.values.each do |hash|
      region = hash.keys.first
      latest_trend_words = Trend.where(region: region, created_at:latest_two_created_at.last).pluck(:trend_word)
      latest_before_trend_word = Trend.where(region: region, created_at:latest_two_created_at.first).pluck(:trend_word)
      new_trend = latest_trend_words - latest_before_trend_word
      existing_trend = latest_trend_words - new_trend
      if latest_before_trend_word.blank?
        trend_hash[region] = {existing: new_trend}
      else
        trend_hash[region] = {new:new_trend, existing: existing_trend}
      end

    end
    trend_hash
  end

  def self.get_history(region)
    latest_ten_created_at = Trend.where(region: region).pluck(:created_at).uniq.last(10).reverse
    history_hash = {}
    latest_ten_created_at.each do |created_at|
      history_hash[created_at.strftime("%Y年%m月%d日 %H時%M分")] = Trend.where(region: region, created_at:created_at).pluck(:trend_word)
    end
    history_hash
  end
end
