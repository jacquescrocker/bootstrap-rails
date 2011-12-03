module Mongo
  puts "Monkey Patching Mongo"
  # Monkey Patch Mongo::Connection to add better logging support
  module Logging

    def instrument(name, payload = {}, &blk)
      start_time = Time.now
      res = yield
      log_operation(name, payload, start_time)
      res
    end

    protected

    def log_operation(name, payload, start_time = nil)
      @logger ||= nil
      return unless @logger
      msg = "#{payload[:database]}['#{payload[:collection]}'].#{name}("
      msg += payload.values_at(:selector, :document, :documents, :fields ).compact.map(&:inspect).join(', ') + ")"
      msg += ".skip(#{payload[:skip]})"  if payload[:skip]
      msg += ".limit(#{payload[:limit]})"  if payload[:limit]
      msg += ".sort(#{payload[:order]})"  if payload[:order]

      duration = (Time.now.to_f - start_time.to_f)*1000
      @logger.debug "MONGODB #{msg} (#{sprintf("%0.02f", duration)}ms)"
    end
  end
end