# An RSpec matcher for the Fakeweb HTTP stubbing library, allowing you to use
# RSpec syntax to check if requests to particular URIs have been made.
# 
# @see FakeWebMatcher::Matchers
# @see http://fakeweb.rubyforge.org
# @author Pat Allan
# 
module FakeWebMatcher
  # Custom matcher holder for RSpec
  # 
  module Matchers
    # Returns a new matcher instance.
    # 
    # @param [Symbol] method The HTTP method
    # @param [String] uri The URI to check for
    # @return [FakeWebMatcher::RequestMatcher]
    # 
    def have_requested(method, uri)
      FakeWebMatcher::RequestMatcher.new(method, uri)
    end
  end
end
