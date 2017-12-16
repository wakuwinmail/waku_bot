words=File.open("data.txt","w:utf-8")#出力用ファイルを開く

words.puts("\n")#ファイルの先頭の文字を上手く読み込めなかったバグがあったため改行を入れています。
File.open("input.txt","r:utf-8") do |file|
    file.each_line do |tweet|
        str=tweet.split(" ")#半角スペースで区切る
        str.insert(0," ")#処理のしやすさの観点から先頭に半角スペースを追加
        str.push(" ")#同様に末尾に半角スペースを追加
        for i in 0..str.length-3 do
            words.puts(str[i]+" "+str[i+1]+" "+str[i+2])#3単語ごとに出力する。
        end
    end
end
