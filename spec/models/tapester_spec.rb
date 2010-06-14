require File.join(File.dirname(__FILE__), "../spec_helper")

require "tapester.rb"

describe Tapester do
  describe "#authenticate" do
    before do
      @tapester = Factory.create(:tapester, :password => "secret")
    end
    it "should authenticate with valid auth" do
      Tapester.authenticate(@tapester.email, "secret").should == @tapester
    end
    it "should not authenticate with invalid auth" do
      Tapester.authenticate(@tapester.email, "wrongsecret").should_not == @tapester
    end
  end
end
