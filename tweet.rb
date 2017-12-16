require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XXXXXXXX"
  config.consumer_secret     = "YYYYYYYY"
  config.access_token        = "ZZZZZZZZ"
  config.access_token_secret = "WWWWWWWW"
end
# tweet
  File.open('result.txt',"r:utf-8") do |file|#wordconnectからの出力ファイルを読み込み
    file.each_line do |text|
      client.update("#{text}")#ツイートする
    end
  end