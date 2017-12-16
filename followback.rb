require 'twitter'
require 'yaml'

config = YAML.load_file("config.yml")

client = Twitter::REST::Client.new(config)

# followback
followerlist=[]
client.follower_ids.each do |id|
  followerlist.push(id)#フォロワーのIDを配列に格納
end

client.follow(followerlist)#フォロワーをフォローする
