require 'fake_web_matcher/extension'
require 'fake_web_matcher/matchers'
require 'fake_web_matcher/request_matcher'

# An RSpec matcher for the Fakeweb HTTP stubbing library, allowing you to use
# RSpec syntax to check if requests to particular URIs have been made.
# 
# The matcher is automatically included into RSpec's set, and can be used as
# follows:
# 
# @example
#   FakeWeb.should have_requested(:get, 'http://example.com')
#   FakeWeb.should have_requested(:any, 'http://example.com')
#   FakeWeb.should_not have_requested(:put, 'http://example.com')
# 
# @see FakeWebMatcher::Matchers
# @see http://fakeweb.rubyforge.org
# @author Pat Allan
# 
module FakeWebMatcher
  #
end

FakeWeb::Registry.class_eval do
  # Don't like doing this, but need some way to track the requests
  include FakeWebMatcher::Extension
end

Spec::Runner.configure { |config|
  # Adding the custom matcher to the default set
  config.include FakeWebMatcher::Matchers
  
  # Ensuring the request list gets cleared after each spec
  config.before :each do
    FakeWeb::Registry.instance.clear_requests
  end
}
