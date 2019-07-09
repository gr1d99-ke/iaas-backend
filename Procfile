release: bin/heroku_release
redis-server: redis-server
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
