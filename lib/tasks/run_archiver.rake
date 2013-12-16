# Rakefile to run archiver
# checks start of every month
namespace :check_hours do
  task :process => :environment do
    begin
      puts "#{Time.now} : check hours in #{ENV['RAILS_ENV']}."
      if Date.today.day == 1
        ProcessHours.process(Date.today.beginning_of_month - 1.month)
      else
        puts "Not start of month"
      end
    rescue => e
      puts "#{Time.now} : something went bad, infact this did: #{e}"

    end
  end
end