require 'resque/server'

module Bootstrap
  class ResqueServer < Resque::Server

    if Settings.resque_server.password.present?
      # protect using basic auth
      use Rack::Auth::Basic do |email, password|
        email == Settings.resque_server.password || password == Settings.resque_server.password
      end
    end

  end
end