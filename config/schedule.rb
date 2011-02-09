# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

every :hour do
  # TODO: al menos con Passenger parece que hay que reiniciar
  # el servidor, o al menos si la búsqueda está en caché.
  rake "xapian_db:reindex"
end

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
#
# every :friday, :at => '10:30 pm'  
#
# every :reboot do
#
# Learn more: http://github.com/javan/whenever
