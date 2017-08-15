class Follower < ApplicationRecord
  require 'json'
  require 'oauth'

  validates :handle_id, :presence => true
  # Twitter APIの認証を通します
  @client = self.create_twitter_client

  def self.get_followers(handle_id, type_id)
    # 登録済みのハンドルは洗い替えます
    if Follower.pluck(:handle_id).uniq.include?(handle_id)
      Follower.destroy_all(handle_id:handle_id)
    end
    begin
      follower_array = []
      follower_ids = @client.follower_ids(handle_id).to_a
      followers = follower_ids.each_slice(100).to_a.reduce([]) do |followers,follower_id|
        # 凍結ユーザーがいた場合、エラーになるので凍結はスルーする
        begin
          @client.users(follower_id)
        rescue => e
          p e.message
          next followers
        end
        followers.concat(@client.users(follower_id))
      end
      followers.each do |follower|
        follower_array << Follower.new(handle_id: handle_id, follower_id:follower.screen_name, type_id:type_id)
      end
      Follower.import follower_array
    rescue Twitter::Error::TooManyRequests => e
      puts e.message
      sleep e.rate_limit.reset_in
      retry
    end
  end

  def self.get_disp_handles
    disp_follower_hash = {}
    Follower.pluck(:type_id).uniq.each do |type_id|
      disp_follower_hash[Type.find(type_id).name] = Follower.where(type_id:type_id).pluck(:handle_id).uniq
    end
    disp_follower_hash
  end


  def self.get_duplicate_user(type_id, duplicate_number)
    Follower.where(type_id:type_id).group(:follower_id).having(['COUNT(follower_id) > ?', duplicate_number]).pluck(:follower_id)
  end




  def self.get_tweet_text(handle_id)
    Tweet.destroy_all
    handle_follower_array = Follower.where(handle_id:handle_id).pluck(:follower_id)
    handle_follower_array.map do |follower_id|
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
