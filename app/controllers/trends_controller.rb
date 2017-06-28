require 'oauth'
require 'json'

class TrendsController < ApplicationController

  def index
    consumer_key        = 'iBALMSi7qgkswso9qQ1rHXrRA'
    consumer_secret     = '2u3ZtTmi93p2Xr2VRaZ7tuD1XFzsqmU0rZZmYzfhtPfUigSGqv'
    access_token        = '848325356985569280-aWTwm6s7MXM8Vv9JcxbZc84XCKwMGM6'
    access_token_secret = 'HCkghdlfqG8HGEp11hD6lMCeVL7B1C2fltNkrNWBgYeIb'

    consumer = OAuth::Consumer.new(
      consumer_key,
      consumer_secret,
      {
        :site   => 'http://api.twitter.com',
        :scheme => :header
      }
    )

    token_hash = {
      :access_token        => access_token,
      :access_token_secret => access_token_secret
    }
    # Twitterへのリクエストトークン作成
    request_token = OAuth::AccessToken.from_hash(consumer, token_hash)
    # 下記の都市のトレンドをハッシュ形式で返す
    woeids = { 1118370 => '東京', 15015370 =>'大阪', 1117817 =>'名古屋', 23424856 =>'日本' }
    # ハッシュ初期化
    @trends_hash = {}
    # 各woeidを回してトレンドを取得し、ハッシュに詰める
    woeids.each do |key, value|
      response_place = request_token.request(:get, "https://api.twitter.com/1.1/trends/place.json?id=#{key}")
      japan_trends = JSON.parse(response_place.body)
      trends = []
      japan_trends[0]['trends'].each do |trend|
        trends << trend['name']
      end
      @trends_hash[value] = trends
    end
    return @trends_hash
  end
end
