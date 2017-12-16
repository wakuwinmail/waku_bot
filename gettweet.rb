require 'twitter'
require 'date'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "XXXXXXXX"
  config.consumer_secret     = "YYYYYYYY"
  config.access_token        = "ZZZZZZZZ"
  config.access_token_secret = "WWWWWWWW"
end

Dir::mkdir("#{Date.today}") if !Dir::exist?("#{Date.today}")
data=File.open("rawtext.txt","w:utf-8")#出力用ファイルを開く
max_id = client.home_timeline.first.id

File.open("#{Date.today}/#{DateTime.now.hour}#{DateTime.now.minute}#{DateTime.now.second}.txt","w:utf-8") do |file|#データベース用のファイルを開く
  15.times do
    #home_timelineの引数
    #max_id:これに入ってるIDより前のツイートを取得
    #count:取得するツイート数。200までらしい
    #include_rts:RTを取得するかどうか
    #exclude_replies:リプライを除外するかどうか
    client.home_timeline(max_id: max_id,count: 200,include_rts: false,exclude_replies: true).each do |tweet|#200*15個のツイートを取得
      s = +tweet.text#解凍処理
      s.slice!(s.index("http")..s.length) if(s.include?("http"))#画像などのリンクを取り除く
      file.print(s) if tweet.lang=="ja"#日本語ならデータベースに追加
      file.puts("\n")
      data.print(s) if tweet.lang=="ja"#日本語なら出力用ファイルに追加
      data.puts("\n")
      max_id = tweet.id
    end
  end
end
data.close