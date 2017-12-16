require 'open3'
def start_proc(ruby_script)
    Open3.capture3("ruby" + " " + ruby_script)
    end
    print "main start\n"
    start_proc("gettweet.rb")
    print "gettweet complete\n"
    start_proc("raw_toinput.rb")
    print "raw_toinput complete\n"
    start_proc("wordcut.rb")
    print "wordcut complete\n"
    start_proc("wordconnect.rb")
    print "wordconnect complete\n"
    start_proc("tweet.rb")
    print "tweet complete\n"
    print "main end\n"