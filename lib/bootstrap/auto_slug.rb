module Bootstrap
  module AutoSlug
    extend ActiveSupport::Concern

    def to_param
      slug || id.to_s
    end

    def reslug!
      @reslug = true
      self.save!
    end

    def slug_match?(slug)
      self.slug.to_s == slug.to_s
    end

    included do
      field :slug, :type => String
      before_save :slugify
    end

    module ClassMethods

      # use the slugs table to find a proper source id
      def find_by_slug(slug)
        slug_record = Mongoid.master["slugs"].find_one({:_id => slug.to_s.downcase, :source_type => self.to_s.downcase})
        if slug_record
          where(:_id => slug_record["source_id"]).first
        else
          nil
        end
      end

      # tries to find by either an id or slug
      def lookup(id_or_slug)
        id_or_slug = id_or_slug.to_s

        # find plan by a specific objectid
        result = where(:_id => id_or_slug).first if BSON::ObjectId.legal?(id_or_slug)
        result ||= find_by_slug(id_or_slug) if id_or_slug.present?

        # make sure the plan exists
        result
      end

      # tries to find by id or slug (throws exception if not found)
      def lookup!(id_or_slug)
        lookup(id_or_slug) || (raise Mongoid::Errors::DocumentNotFound.new(self, id_or_slug))
      end

      # setup slug
      def slug_config
        {
          :max_tries => 10,
          :letter_count => 6,
          :letters => "abcdefghkmnpqrstuvwxyz",
          :numbers => "234578",
        }.dup
      end
    end

    protected

    def slugify
      if new_record? || reslug?
        self.slug = generate_unique_slug

        # add slug record to database
        Mongoid.master["slugs"].insert({
          :_id => self.slug,
          :source_id => self.id,
          :source_type => self.class.to_s.downcase
        })

      end
      @reslug = false
      self.slug
    end

    def generate_unique_slug
      slug_config = self.class.slug_config

      letters = slug_config[:letters].chars.to_a

      # get a random path
      random_path = ""
      slug_config[:letter_count].times do
        # pick out a random letter (and remove from the list)
        sample = letters.delete(letters.sample)

        # append it to random_path
        random_path << sample
      end

      # randomly swap the 2nd or 3rd letter with a number
      numbers = slug_config[:numbers].chars.to_a
      index_swap = rand(slug_config[:letter_count]-2)+1
      random_path[index_swap] = numbers.sample

      # check if the slug is already there
      slug_record = Mongoid.master["slugs"].find_one({:_id => random_path})

      # if there is an existing match, then increment the suffix
      if slug_record and slug_record["source_id"] != self.id
        generate_unique_slug
      else
        self.slug = random_path
        random_path
      end
    end

    def reslug?
      return true if @reslug
    end

  end
end