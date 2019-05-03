# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
every 1.day do
  command "cd /opt/doris-hyku/current/ops/Backups && dotenv -f ../../.env 'backup perform --trigger hyku -c ./config.rb'"
end

every 1.hour do
  command "cd /opt/doris-hyku/current/tmp && find . -ctime +7 -and -size +1M  -delete"
end
