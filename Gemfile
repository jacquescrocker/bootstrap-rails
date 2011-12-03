source 'http://rubygems.org'

gem "sprockets", :git => "git://github.com/railsjedi/sprockets.git"
gem 'rails', '3.1.3'

gem "bcrypt-ruby"

gem 'jquery-rails'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'json'
gem 'jquery-rails'

# mongoid http://github.com/mongoid/mongoid
gem "bson", "1.4.0"
gem "bson_ext", "1.4.0"
gem "mongo", "1.4.0"
gem "mongoid", ">= 2.3.2"

# rails config http://github.com/railsjedi/rails_config
gem "rails_config", ">= 0.2.3"

# redis / resque / resque scheduler
gem "redis"
gem "resque"
gem "resque-scheduler"

# sprite http://github.com/railsjedi/sprite
gem "rmagick"
gem "sprite", ">= 0.2.5"

gem "thin"
gem "unicorn"

# more useful gems:
# gem "stripe"          # billing
# gem "hirefireapp"     # autoscaling for heroku
# gem "airbrake"        # exception handler
# gem "omniauth"        # for oauth integration
# gem "chronic"         # date/time parsing
# gem "koala"           # facebook library
# gem "validate_email"  # validates email
# gem "pusher"          # push notifications
# gem "streama"         # activity feeds for mongoid

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'handlebars_assets'

  gem 'execjs', :git => 'git://github.com/sstephenson/execjs.git'

  # stylus http://learnboost.github.com/stylus
  # nib http://visionmedia.github.com/nib/
  gem "stylus-source", :git => "git://github.com/railsjedi/ruby-stylus-source.git"
  gem "stylus", :git => "git://github.com/railsjedi/ruby-stylus.git"
  gem "stylus-nib", :git => "git://github.com/railsjedi/ruby-stylus-nib.git"

  # http://lesscss.org/
  # http://twitter.github.com/bootstrap/
  gem 'less-rails-bootstrap'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'yui-compressor', :require => 'yui/compressor'
end

group :development do
  gem "launchy", "~> 0.3.7"
  gem "heroku-rails", ">= 0.3.2"

  # setup guard
  gem "guard"
  gem "guard-pusher", :git => "http://github.com/railsjedi/guard-pusher.git"
  gem "guard-coffeescript", ">= 0.4.0"
  gem "guard-resque", ">= 0.0.2"

  # https://github.com/achiu/terminitor
  gem "terminitor", ">= 0.6.0"
end

group :development, :test do
  gem "ruby-debug", :platforms => :mri_18
  gem "ruby-debug19", :platforms => :mri_19, :require => 'ruby-debug'

  gem "fabrication"
  gem 'ffaker'
  gem "rspec-rails", ">= 2.5.0"

  gem "rb-fsevent"
  gem "growl"
  gem 'growl_notify'
end

group :test do
  gem "webmock", :require => nil
  gem "vcr", :require => nil
  gem 'capybara'
  # gem 'webrat'

  gem "pickle"

  gem 'spork', '>= 0.9.0.rc9'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'guard-cucumber'

  gem 'remarkable_mongoid'
  gem 'cucumber-rails', '>= 1.0.2'

  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
end