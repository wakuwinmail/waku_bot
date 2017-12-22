require 'natto'

natto = Natto::MeCab.new#形態素解析ライブラリのオブジェクト作成

input=File.open("input.txt","w")#出力用ファイルを開く

File.open("rawtext.txt","r:utf-8") do |file|#文章ファイルを開く
  file.each_line do |words|
    natto.parse(words) do |n|#文章を単語ごとに分割する
      input.print(" #{n.surface}") #出力用ファイルに書き出し
    end
    input.puts("\n")
  end
end