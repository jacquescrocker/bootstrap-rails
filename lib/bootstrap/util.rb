module Bootstrap
  module Util
    def self.cleanup_phone_number(number)
      number.to_s.strip.gsub(%r{\D}, "").gsub(%r{^\+1}, "").gsub(%r{^1}, "")
    end
  end
end