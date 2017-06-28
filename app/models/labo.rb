require 'oauth'
require 'json'

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

request_token.request(:get, 'https://api.twitter.com/1.1/followers/list.json?screen_name=Butch_Gen')

response_place = request_token.request(:get, 'https://api.twitter.com/1.1/followers/list.json?screen_name=Butch_Gen')
p JSON.parse(response_place.body)['users'][0]