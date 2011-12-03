module Bootstrap
  module Routing
    class MobileSubdomain
      def initialize
        @matched = ["m"]
      end

      def matches?(request)
        subdomain = request.subdomain.to_s

        # skip route if we dont have a valid subdomain
        return true if @matched.include?(subdomain)

        return false
      end

    end
  end
end