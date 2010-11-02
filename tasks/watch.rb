require 'open3'

def thread cmd
  Thread.new {
    Open3.popen3 "#{cmd} 2>&1" do |stdin,stdout,stderr|
      while true
        puts stdout.gets
        sleep 0.1
      end
    end
  }
end

task :watch do
  [
    thread("coffee -cw -o app/public/scripts app/scripts/*.coffee"),
    thread("sass --watch app/styles:app/public/styles")
  ].each(&:join)
end
