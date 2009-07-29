module FakeWebMatcher
  # Matcher class, following RSpec's expectations. Used to confirm whether a
  # request has been made on a given method and URI.
  # 
  class RequestMatcher
    attr_reader :url, :method
    
    # Create a new matcher.
    # 
    # @param [Symbol] method The HTTP method. Defaults to :any if not supplied.
    # @param [String] uri The URI to check for
    # 
    def initialize(*args)
      @method, @url = args_split(*args)
    end
    
    # Indication of whether there's a match on the URI from given requests.
    # 
    # @param [Module] FakeWeb Module, necessary for RSpec, although not
    #   required internally.
    # @return [Boolean] true if the URI was requested, otherwise false.
    # 
    def matches?(fakeweb)
      !FakeWeb::Registry.instance.requests.detect { |req|
        method, url = args_split(*req)
        match_method(method) && url == @url
      }.nil?
    end
    
    # Failure message if the URI should have been requested.
    # 
    # @return [String] failure message
    # 
    def failure_message
      if @method == :any
        "The URL #{@url} was not requested."
      else
        "The URL #{@url} was not requested using #{formatted_method}."
      end
    end
    
    # Failure message if the URI should not have been requested.
    # 
    # @return [String] failure message
    #
    def negative_failure_message
      if @method == :any
        "The URL #{@url} was requested and should not have been."
      else
        "The URL #{@url} was requested using #{formatted_method} and should not have been."
      end
    end
    
    private
    
    # Compares methods, or ignores if either side of the comparison is :any.
    # 
    # @param [Symbol] method HTTP method
    # @return [Boolean] true if methods match or either is :any.
    # 
    def match_method(method)
      @method == :any || method == :any || method == @method
    end
    
    # Expected method formatted to be an uppercase string. Example: :get becomes
    # "GET".
    # 
    # @return [String] uppercase method
    # 
    def formatted_method
      @method.to_s.upcase
    end
    
    # Interprets given arguments to a method and URI instance. The URI, as a
    # string, is required, but the method is not (will default to :any).
    # 
    # @param [Array] args
    # @return [Array] Two items: method and URI instance
    # 
    def args_split(*args)
      method  = :any
      uri     = nil
      
      case args.length
      when 1 then uri         = URI.parse(args[0])
      when 2 then method, uri = args[0], URI.parse(args[1])
      else
        raise ArgumentError.new("wrong number of arguments")
      end
      
      return method, uri
    end
  end
end
