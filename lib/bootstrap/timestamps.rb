module Bootstrap
  module Timestamps
    extend ActiveSupport::Concern

    included do
      # set created at timestamp (for filtering purposes)
      field :timestamp, :type => Integer, :default => 0
      index :timestamp

      # get the latest timestamp
      scope :since, lambda{|last_updated| where(:timestamp.gte => last_updated.to_i) }

      # limit the orders for today
      scope :recent, lambda{
        time = Time.now - 24.hours
        where(:timestamp.gte => (time.to_f*1000).to_i)
      }

      # order by last updated
      scope :latest, descending(:timestamp)

      # update the timestamp on save
      before_save :update_timestamp
      def update_timestamp
        self.timestamp = (Time.now.to_f*1000).to_i
      end

    end

  end
end