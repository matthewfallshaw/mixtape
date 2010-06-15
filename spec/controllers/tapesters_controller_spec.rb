require File.join(File.dirname(__FILE__), "../spec_helper")

require "tapesters_controller.rb"

describe TapestersController do
  describe "#show" do
    it "should generate a reset_password_token when @tapester is an orphan" do
      tapester = Factory.build(:tapester)
      tapester.stub!(:orphan?).and_return(true)
      Tapester.stub!(:find).and_return(tapester)

      tapester.should_receive(:generate_reset_password_token!)

      get :show, :id => 1
    end
    it "should now generate a reset_password_token when @tapester is not an orphan" do
      tapester = Factory.build(:tapester)
      tapester.stub!(:orphan?).and_return(false)
      Tapester.stub!(:find).and_return(tapester)

      tapester.should_not_receive(:generate_reset_password_token!)

      get :show, :id => 1
    end
  end
end
