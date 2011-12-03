require File.expand_path('../config/environment', __FILE__)

group 'assets' do
  if Settings.dev_reload_channel.present?
    guard 'pusher', :app_id => Settings.pusher.app_id, :key => Settings.pusher.key, :secret => Settings.pusher.secret, :channel => "guard-pusher-#{Settings.dev_reload_channel}" do
      watch(%r{^app/assets/javascripts/(.+\.coffee)})
      watch(%r{^app/assets/stylesheets/(.+\.scss)})
      watch(%r{^app/assets/stylesheets/(.+\.less)})
      watch(%r{^app/assets/stylesheets/(.+\.sass)})
      watch(%r{^app/assets/stylesheets/(.+\.css)})
      watch(%r{^app/assets/stylesheets/(.+\.styl)})
      watch(%r{^app/assets/(.+\.hbs)})
      watch(%r{^app/views/(.+\.erb)})
      watch(%r{^app/views/(.+\.haml)})
      watch(%r{^app/views/(.+\.slim)})
    end
  end
  # prevalidate coffeescript syntax on save
  guard 'coffeescript', :input => 'app/assets/javascripts', :noop => true #, :hide_success => true
end

group 'workers' do
  guard 'resque', :environment => 'development', :queue => "*", :verbose => true, :trace => true do
    watch(%r{^app/(.+)\.rb})
    watch(%r{^lib/(.+)\.rb})
    watch(%r{^config/(.+\.rb)})
    watch(%r{^config/(.+\.yml)})
  end
end

group 'spork' do
  guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
    watch('config/application.rb')
    watch('config/environment.rb')
    watch(%r{^config/environments/.+\.rb$})
    watch(%r{^config/initializers/.+\.rb$})
    watch('Gemfile')
    watch('Gemfile.lock')
    watch('spec/spec_helper.rb')
    watch(%r{^spec/support/.+\.rb$})
    watch(%r{^features/support/.+\.rb$})
  end
end

group 'tdd' do
  guard 'rspec', :version => 2, :cli => "--color --format progress", :all_on_start => false, :all_after_pass => false, 'RAILS_ENV' => 'test'  do
    watch('spec/spec_helper.rb')                       { "spec" }
    watch('config/routes.rb')                          { "spec/routing" }
    watch('app/controllers/application_controller.rb') { "spec/controllers" }
    watch(%r{^spec/.+_spec\.rb})
    watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  end

  guard 'cucumber', :cli => "--drb", :all_on_start => false, :all_after_pass => false, 'RAILS_ENV' => 'test'  do
    watch(%r{features/.+\.feature})
    watch(%r{features/support/.+})                      { 'features' }
    watch(%r{features/step_definitions/(.+)_steps\.rb}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  end
end
