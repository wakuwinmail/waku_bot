require 'twitter'
require 'date'
require 'yaml'

config = YAML.load_file("config.yml")

client = Twitter::REST::Client.new(config)

now = DateTime.now
dir_name = now.strftime("%Y-%m-%d")
file_name = now.strftime("%H%M%S")

Dir::mkdir("#{dir_name}") if !Dir::exist?("#{dir_name}")
data=File.open("rawtext.txt","w:utf-8")#出力用ファイルを開く
ngwords=File.open("ngwords.txt","r:utf-8")#NGワードが書かれたファイルを開く
max_id = client.home_timeline.first.id

File.open("#{dir_name}/#{file_name}.txt","w:utf-8") do |file|#データベース用のファイルを開く
  15.times do
    #home_timelineの引数
    #max_id:これに入ってるIDより前のツイートを取得
    #count:取得するツイート数。200までらしい
    #include_rts:RTを取得するかどうか
    #exclude_replies:リプライを除外するかどうか
    client.home_timeline(max_id: max_id,count: 200,include_rts: false,exclude_replies: true).each do |tweet|#200*15個のツイートを取得
      flag=true
      ngwords.each_line do |words|
        if /#{words}/ =~ tweet.text
          flag=false
          break
        end
      end
      if tweet.lang == "ja" && flag#日本語かつNGワードが含まれていないならデータベースに追加する処理をする
        s = +tweet.text#解凍処理
        s.slice!(s.index("http")..s.length) if(s.include?("http"))#画像などのリンクを取り除く
        file.print(s)#日本語ならデータベースに追加
        file.puts("\n")
        data.print(s)#日本語なら出力用ファイルに追加
        data.puts("\n")
      end
      max_id = tweet.id
    end
  end
end
data.close
