module FakeWebMatcher
  # Matcher class, following RSpec's expectations. Used to confirm whether a
  # request has been made on a given method and URI.
  #

  # Monkey patch to add a normalize! method to the URI::HTTP class.
  # It doesn't currently sort the query params which means two URLs
  # that are equivalent except for a different order of query params
  # will be !=. This isn't how FakeWeb works, so we patch it here.
  class ::URI::HTTP

    # Normalize an HTTP URI so that query param order differences don't
    # affect equality.
    def normalize!
      if query
        normalised_query = self.query.split('&').sort.join('&')
        if respond_to? :set_query
          set_query normalised_query
        else
          self.query = normalised_query
        end
      end

      super
    end
  end

  class RequestMatcher
    attr_reader :url, :method

    # Create a new matcher.
    #
    # @param [Symbol] method The HTTP method. Defaults to :any if not supplied.
    # @param [String, Regexp] uri The URI to check for
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
        match_method(method) && match_url(url)
      }.nil?
    end

    # Failure message if the URI should have been requested.
    #
    # @return [String] failure message
    #
    def failure_message
      regex?(@url) ? regex_failure_message : url_failure_message
    end

    # Failure message if the URI should not have been requested.
    #
    # @return [String] failure message
    #
    def negative_failure_message
      regex?(@url) ? regex_negative_failure_message : url_negative_failure_message
    end

    # Failure message if the URI should not have been requested.
    #
    # @return [String] failure message
    #
    def failure_message_when_negated
      regex?(@url) ? regex_negative_failure_message : url_negative_failure_message
    end

    private

    def regex_negative_failure_message
      "A URL that matches #{@url.inspect} was requested#{failure_message_method} and should not have been."
    end

    def url_negative_failure_message
      "The URL #{@url} was requested#{failure_message_method} and should not have been."
    end

    def regex_failure_message
        "A URL that matches #{@url.inspect} was not requested#{failure_message_method}."
    end

    def url_failure_message
        "The URL #{@url} was not requested#{failure_message_method}."
    end

    def failure_message_method
      " using #{formatted_method}" unless @method == :any
    end

    # Compares methods, or ignores if either side of the comparison is :any.
    #
    # @param [Symbol] method HTTP method
    # @return [Boolean] true if methods match or either is :any.
    #
    def match_method(method)
      @method == :any || method == :any || method == @method
    end

    # Compares the url either by match it agains a regular expression or
    # by simple comparison
    #
    # @param [String] url the called URI
    # @return [Boolean] true if exprexted URI and called URI match.
    #
    def match_url(url)
      return @url.match(url.to_s) if regex?(@url)
      @url == url
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
    # @return [Array] Two items: method and URI instance or regular expression
    #
    def args_split(*args)
      method  = :any
      uri     = nil

      case args.length
      when 1 then uri         = args[0]
      when 2 then method, uri = args[0], args[1]
      else
        raise ArgumentError.new("wrong number of arguments")
      end
      uri = URI.parse(uri) unless regex?(uri)
      return method, uri
    end

    def regex?(object)
      object.is_a?(Regexp)
    end
  end
end
