require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XXXXXXXX"
  config.consumer_secret     = "YYYYYYYY"
  config.access_token        = "ZZZZZZZZ"
  config.access_token_secret = "WWWWWWWW"
end
# followback
followerlist=[]
client.follower_ids.each do |id|
  followerlist.push(id)#フォロワーのIDを配列に格納
end

client.follow(followerlist)#フォロワーをフォローする