redis:  redis-server config/redis.conf
resque: QUEUE=* bundle exec rake resque:work
web:    bundle exec thin start -C config/thin.yml
