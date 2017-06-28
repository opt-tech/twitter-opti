class Follower < ApplicationRecord

  # Twitter APIの認証を通します
  @client = Twitter::REST::Client.new(
    consumer_key: 'iBALMSi7qgkswso9qQ1rHXrRA',
    consumer_secret:   '2u3ZtTmi93p2Xr2VRaZ7tuD1XFzsqmU0rZZmYzfhtPfUigSGqv',
    access_token:        '848325356985569280-aWTwm6s7MXM8Vv9JcxbZc84XCKwMGM6',
    access_token_secret: 'HCkghdlfqG8HGEp11hD6lMCeVL7B1C2fltNkrNWBgYeIb',
  )


  def self.get_followers(handle_id)
    # 登録済みのハンドルは洗い替えます
    if Follower.pluck(:handle_id).uniq.include?(handle_id)
      Follower.destroy_all(handle_id:handle_id)
    end
    follower_array = []
    followers = @client.followers(handle_id)
    followers.each do |follower|
      follower_array << Follower.new(handle_id: handle_id, follower_id:follower.screen_name)
    end
    Follower.import follower_array
  end

  def self.get_tweet_text(handle_id)
    Tweet.destroy_all
    handle_follower_array = Follower.where(handle_id:handle_id).pluck(:follower_id)
    handle_follower_array.map do |follower_id|
      p follower_id
      @client.user_timeline(follower_id).each do |timeline|
        p @client.status(timeline.id)
        tweet_array = Tweet.new(handle_id:follower_id, tweet: @client.status(timeline.id).text)
        begin
          tweet_array.save!
        rescue => e
          p e.message
          next
        end
       end
    end
  end
end
