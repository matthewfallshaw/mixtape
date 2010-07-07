require File.join(File.dirname(__FILE__), "../spec_helper")

require "tape.rb"

describe Tape do
  describe "#track_for(tapester)" do
    it "should return nil when no associated track exists" do
      @tape = Factory.build(:tape)
      @tapester = Factory.build(:tapester)
      @tape.track_for(@tapester).should be_nil
    end
    it "should return that tapester's track when such exists" do
      @tape = Factory.create(:tape)
      @tapester = Factory.create(:tapester)
      track = Factory.create(:track, :tapester => @tapester, :tape => @tape)

      @tape.track_for(@tapester).should == track
    end
  end

  describe "#uncommitted_tapesters" do
    it "should include tapesters with a track on this tape"
    it "should not include tapesters without a track on this tape"
  end
end
