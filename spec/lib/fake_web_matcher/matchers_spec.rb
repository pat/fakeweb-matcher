require 'spec_helper'

describe FakeWebMatcher::Matchers do
  describe '#have_requested' do
    before :each do
      class Matchbox
        include FakeWebMatcher::Matchers
      end
      
      @matcher = Matchbox.new.have_requested(:put, 'http://url.com')
    end
    
    it "should return an instance of RequestMatcher" do
      @matcher.should be_a(FakeWebMatcher::RequestMatcher)
    end
    
    it "should set the url and method using the matcher arguments" do
      @matcher.url.to_s.should  == 'http://url.com'
      @matcher.method.should    == :put
    end
  end
  
  it "should pass if the request has been made" do
    FakeWeb.register_uri(:get, 'http://example.com/', :body => 'foo')
    open('http://example.com/')
    
    FakeWeb.should have_requested(:get, 'http://example.com')
  end
  
  it "should pass if the request has not been made" do
    FakeWeb.register_uri(:get, 'http://example.com/', :body => 'foo')
    
    FakeWeb.should_not have_requested(:get, 'http://example.com')
  end

  it "should not care about the order of the query parameters" do
    FakeWeb.register_uri(:get, URI.parse('http://example.com/page?foo=bar&baz=qux'), :body => 'foo')
    open('http://example.com/page?baz=qux&foo=bar')

    FakeWeb.should have_requested(:get, 'http://example.com/page?foo=bar&baz=qux')
  end
end
