require 'spec/spec_helper'

describe FakeWebMatcher::RequestMatcher do
  describe '#initialize' do
    it "should set the url if no method is supplied" do
      matcher = FakeWebMatcher::RequestMatcher.new('http://example.com')
      matcher.url.to_s.should == 'http://example.com'
    end
    
    it "set the url if a method is explicitly supplied" do
      matcher = FakeWebMatcher::RequestMatcher.new(:get, 'http://example.com')
      matcher.url.to_s.should == 'http://example.com'
    end
    
    it "should set the method to any if not supplied" do
      matcher = FakeWebMatcher::RequestMatcher.new('http://example.com')
      matcher.method.should == :any
    end
    
    it "set the method if explicitly supplied" do
      matcher = FakeWebMatcher::RequestMatcher.new(:get, 'http://example.com')
      matcher.method.should == :get
    end
  end
  
  describe '#matches?' do
    before :each do
      FakeWeb.register_uri(:get, 'http://example.com/', :body => 'foo')
      open('http://example.com/')
    end
    
    it "should return true if same url and any method" do
      matcher = FakeWebMatcher::RequestMatcher.new('http://example.com')
      matcher.matches?(FakeWeb).should be_true
    end
    
    it "should return true if same url and same explicit method" do
      matcher = FakeWebMatcher::RequestMatcher.new(:get, 'http://example.com')
      matcher.matches?(FakeWeb).should be_true
    end
    
    it "should return false if same url and different explicit method" do
      matcher = FakeWebMatcher::RequestMatcher.new(:post, 'http://example.com')
      matcher.matches?(FakeWeb).should be_false
    end
    
    it "should return false if different url and same method" do
      matcher = FakeWebMatcher::RequestMatcher.new(:get, 'http://domain.com')
      matcher.matches?(FakeWeb).should be_false
    end
    
    it "should return false if different url and different explicit method" do
      matcher = FakeWebMatcher::RequestMatcher.new(:post, 'http://domain.com')
      matcher.matches?(FakeWeb).should be_false
    end
  end
  
  describe '#failure_message' do
    it "should mention the method if explicitly set" do
      matcher = FakeWebMatcher::RequestMatcher.new(:get, 'http://example.com')
      matcher.failure_message.
        should == 'The URL http://example.com was not requested using GET.'
    end
    
    it "should not mention the method if not explicitly set" do
      matcher = FakeWebMatcher::RequestMatcher.new('http://example.com')
      matcher.failure_message.
        should == 'The URL http://example.com was not requested.'
    end
  end
  
  describe '#negative_failure_message' do
    it "should mention the method if explicitly set" do
      matcher = FakeWebMatcher::RequestMatcher.new(:get, 'http://example.com')
      matcher.negative_failure_message.
        should == 'The URL http://example.com was requested using GET and should not have been.'
    end
    
    it "should not mention the method if not explicitly set" do
      matcher = FakeWebMatcher::RequestMatcher.new('http://example.com')
      matcher.negative_failure_message.
        should == 'The URL http://example.com was requested and should not have been.'
    end
  end
end
