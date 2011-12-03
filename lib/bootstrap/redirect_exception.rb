# Raise this anywhere in a controller to provide a redirect to a url
module Bootstrap
  class RedirectException < StandardError

    attr_accessor :url
    def initialize(url)
      @url = url
    end

  end
end