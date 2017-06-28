require 'twitter'

client = Twitter::REST::Client.new(
  consumer_key: 'iBALMSi7qgkswso9qQ1rHXrRA',
  consumer_secret:   '2u3ZtTmi93p2Xr2VRaZ7tuD1XFzsqmU0rZZmYzfhtPfUigSGqv',
  access_token:        '848325356985569280-aWTwm6s7MXM8Vv9JcxbZc84XCKwMGM6',
  access_token_secret: 'HCkghdlfqG8HGEp11hD6lMCeVL7B1C2fltNkrNWBgYeIb',
)

p "抽出したいワードを入力してください"
query = gets.chomp
p "取得件数を入力してください"
count = gets.to_i
# 検索処理
result_tweets = client.search(query, count: count, result_type: "recent", exclude: "retweets")

# 検索結果を回す
result_tweets.take(count).each_with_index do |tw, i|
    p "#{i+1}件目========================================================================================"
    p "ID: #{tw.id}"
    p "ユーザー名: #{tw.user.name}"
    p "スクリーン名: #{tw.user.screen_name}"
    p "ツイート数: #{tw.user.statuses_count}"
    p "フォロー数: #{tw.user.friends_count}"
    p "フォロワー数: #{tw.user.followers_count}"
    p "リツイート数: #{tw.retweet_count}"
    p "お気に入り数: #{tw.favorite_count}"
    p "本文: #{tw.full_text}"
  if i+1 == count
      p "=============================================================================================="
  end
end

puts
p "フォロワー一覧取得取得します"
p "idを入力"
id = gets
p "件数を入力"
ct = gets.to_i
followers = client.followers(id).take(ct)
p followers[0].to_json

followers.each_with_index  do |followers, i|
  p "#{i+1}件目========================================================================================"
  puts "ユーザー名: #{followers.screen_name}"
  puts "アカウント名: #{followers.name}"
end


# puts
# p "自分のアカウントでツイートしてみる?(1:呟く)"
# chk = gets.to_i
# if chk == 1
#   # updateで呟く
#   p "ツイート内容を入力してください"
#   client.update(gets)
#   p "自分のアカウントで呟かれてるので確認してみてね"
# end
#
# puts
# p "フォローしたい人いる(1:いる)"
# chk = gets.to_i
# if chk == 1
#     p "IDかアカウント名入力してね"
#     client.follow(gets.chomp)
#     p "check it out"
# end
#
