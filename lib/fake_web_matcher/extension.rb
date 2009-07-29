module FakeWebMatcher
  # Extension for FakeWeb::Registry, to track requests made for given URIs. The
  # code that includes this into FakeWeb is in the base FakeWebMatcher module.
  # 
  # @see http://fakeweb.rubyforge.org
  # 
  module Extension
    def self.included(base)
      base.class_eval do
        # Keep the original response_for method
        alias_method :response_without_request_tracking, :response_for
        
        # Overwrites the existing FakeWeb::Registry#response method, to ensure
        # requests are tracked. Returns the usual stubbed response.
        # 
        # @param [Symbol] method HTTP method
        # @param [String] uri URI requested
        # @param [Proc] block The block passed into Net::HTTP requests
        # @return [String] The stubbed page response
        # 
        def response_for(method, uri, &block)
          requests << [method, uri]
          response_without_request_tracking(method, uri, &block)
        end
      end
    end
    
    # A list of the requests, kept as an array of arrays, where each child array
    # has two values - the method and the URI.
    # 
    # @return [Array] Recorded requests
    # 
    def requests
      @requests ||= []
    end
    
    # Clears the stored request list
    # 
    def clear_requests
      requests.clear
    end
  end
end
