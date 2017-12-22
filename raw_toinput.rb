require 'natto'

natto = Natto::MeCab.new#形態素解析ライブラリのオブジェクト作成

input=File.open("input.txt","w:utf-8")#出力用ファイルを開く

File.open("rawtext.txt","r:utf-8") do |file|#文章ファイルを開く
  file.each_line do |words|
    # 文章を正規化し単語ごとに分割する（natto.parse が Shift JIS じゃないと効かないっぽい？）
    natto.parse(words.unicode_normalize(:nfkc).encode("shift_jis")) do |n|
      input.print(" #{n.surface}") #出力用ファイルに書き出し
    end
    input.puts("\n")
  end
end
