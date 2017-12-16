result=File.open("result.txt","w:utf-8")

head=[]
body=[]
foot=[]
sentence=""
temp=[]

File.open("data.txt","r:utf-8") do |file|
    file.each_line do |words|
        if /^ / =~ words then
            head.push(words)
        elsif !words.include?("  ") then
            body.push(words)
        else foot.push(words)
        end
    end
end

sentence=sentence+head[rand(0..head.length-1)].chomp!
#puts head.length
#=begin
while true do
    temp=sentence.split(" ")
    footflag=false
    foot.each do |words|
        if /#{temp[temp.length-2]} #{temp[temp.length-1]}/ =~ words then
            footflag=true
        end
        break if footflag
    end
    bodyflag=false
    body.each do |words|
        if /^#{temp[temp.length-2]} #{temp[temp.length-1]}/ =~ words then
            a=words.split(" ")
            sentence=sentence+" "+a[a.length-1]
            bodyflag=true
        end
        break if bodyflag
    end
    #puts "#{temp[temp.length-2]} #{temp[temp.length-1]}"
    break if sentence.length>130 || footflag || footflag==bodyflag
end
result.puts(sentence.gsub(" ",""))
#=end
result.close