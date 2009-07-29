$:.unshift File.dirname(__FILE__) + '/../lib'

require 'rubygems'
require 'open-uri'
require 'spec'
require 'fake_web'
require 'fake_web_matcher'

Spec::Runner.configure do |config|
  #
end
