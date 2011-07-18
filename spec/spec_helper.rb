$:.unshift File.dirname(__FILE__) + '/../lib'
$:.unshift File.dirname(__FILE__) + '/.'

require 'rubygems'
require 'bundler'
 
Bundler.require :default, :development

require 'open-uri'
require 'fake_web'
require 'fake_web_matcher'
