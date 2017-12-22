head = []
body = []
sentence = ""

File.open("data.txt", "r:utf-8") do |file|
    file.each_line do |words|
        words.chomp!
        if /^ / =~ words then
            head.push(words)
        else
            body.push(words)
        end
    end
end

# 空白で始まる行をランダムで選ぶ。後ろ２つの形態素を拾って開始
# （split の第２引数は空文字も区切るためのもの）
temp = head.sample.split(" ", -1).slice(-2..-1)
sentence += temp.join("")

while true do
    # 文末だったら終了（初回で形態素１つの可能性があるのでこの処理は最初にやる）
    break if temp.last == ""

    # searchstr で始まる行を検索する。見つからなければ終了（見つからないことはないはず）
    searchstr = temp.join(" ")
    selected = body.select {|words| words.start_with?(searchstr) }
    break if selected.empty?

    # ランダムで形態素を拾う。文が長ければ終了
    temp.shift
    temp << selected.sample.split(" ", -1).last
    break if sentence.length + temp.last.length > 130
    sentence += temp.last
end

File.open("result.txt", "w:utf-8") do |file|
    file.puts(sentence)
end
