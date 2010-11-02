Dir.glob(File.dirname(__FILE__) + '/tasks/*.rb') { |f| require f }

desc "Heroku runs this task hourly"
task :cron => :update
