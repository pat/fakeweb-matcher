require 'spec/spec_helper'

describe FakeWebMatcher::Extension do
  it "should be included into the FakeWeb::Registry class" do
    FakeWeb::Registry.included_modules.should include(FakeWebMatcher::Extension)
  end
  
  describe '#requests' do
    it "should return an empty Array by default" do
      FakeWeb::Registry.instance.requests.should == []
    end
  end
  
  describe '#clear_requests' do
    it "should clear the requests array" do
      registry = FakeWeb::Registry.instance
      registry.requests << :something
      registry.requests.should == [:something]
      
      registry.clear_requests
      registry.requests.should == []
    end
  end
  
  describe '#response_for' do
    before :each do
      @registry = FakeWeb::Registry.instance
    end
    
    it "should track request" do
      @registry.response_for(:any, 'http://uri.com')
      
      @registry.requests.should == [[:any, 'http://uri.com']]
    end
    
    it "should return the underlying response from response_without_request_tracking" do
      @registry.stub!(:response_without_request_tracking => :response)
      
      @registry.response_for(:any, 'http://uri.com').should == :response
    end
  end
end
