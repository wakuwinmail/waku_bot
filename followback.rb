require 'twitter'
require 'yaml'

config = YAML.load_file("config.yml")

client = Twitter::REST::Client.new(config)

# followback
ngwords=File.open("ngwords.txt","r:utf-8")#NGワードが書かれたファイルを開く

client.follower_ids.each do |id|#フォロワーのIDを取得
  flag=true
  ngwords.each_line do |words|
    if /#{words}/ =~ client.user(id).description then#NGワードが含まれていたらフォローしない
      flag=false
      break
    end
  end
  client.follow(id) if flag
  sleep(61)#API制限回避用
end