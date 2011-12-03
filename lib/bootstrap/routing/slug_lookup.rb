module Bootstrap
  module Routing

    class SlugLookup
      def initialize(source_type)
        @source_type = source_type
      end

      def matches?(request)
        path = request.path.split("/").last.downcase

        # see if there's a matching slug
        Mongoid.master["slugs"].find({ :_id => path, :source_type => @source_type }).count > 0
      end
    end

  end
end
