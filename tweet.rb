require 'twitter'
require 'yaml'

config = YAML.load_file("config.yml")

client = Twitter::REST::Client.new(config)

# tweet
  File.open('result.txt',"r:utf-8") do |file|#wordconnectからの出力ファイルを読み込み
    file.each_line do |text|
      client.update("#{text}")#ツイートする
    end
  end
