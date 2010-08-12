require 'benchmark'
module Calculated
  @@logger = nil
  def self.logger=(logger)
    @@logger = logger
  end
  def self.logger
    @@logger
  end

  module Logging
    def self.log_calculated_api(method, path, options)
      message = method 
      dump = format_da_dump(path, options)
      if block_given?
        result = nil
        seconds = Benchmark.realtime { result = yield }
        log_info(message, dump, seconds) 
        result
      else
        log_info(message, dump) 
        nil
      end
    rescue Exception => e
      exception = "#{e.class.name}: #{e.message}: #{dump}"
      log_info(message, exception)
      raise
    end
    
    def self.format_da_dump(path, params)
      "Calculated: PATH: #{path} PARAMS: #{params.inspect}"
    end
    
    def self.log_info(message, dump, seconds = 0)
      return unless Calculated.logger
      log_message = "#{message} (#{seconds}) #{dump}"
      Calculated.logger.info(log_message)
    end
    
  end  
end