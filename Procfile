# web: bundle exec thin start -p $PORT
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb

# resque: bundle exec rake QUEUE=* jobs:work
# scheduler: bundle exec rake resque:scheduler
