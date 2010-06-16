require File.join(File.dirname(__FILE__), "../spec_helper")

require "track.rb"

describe Track do
  describe "#url" do
    it "should normalise http part" do
      track = Factory.build(:track, :url => "www.youtube.com/watch?v=FtbCx-i2Whg")
      track.url.should == "http://www.youtube.com/watch?v=FtbCx-i2Whg"
      track.should be_valid
    end
    it "should allow start times" do
      track = Factory.build(:track, :url => "http://www.youtube.com/watch?v=FtbCx-i2Whg#t=12s")
      track.url.should == "http://www.youtube.com/watch?v=FtbCx-i2Whg#t=12s"
      track.should be_valid
    end
    it "should swallow other arguments" do
      track = Factory.build(:track, :url => "youtube.com/watch?v=sISJkCJ7Jto&feature=related#t=12s")
      track.url.should == "http://www.youtube.com/watch?v=sISJkCJ7Jto#t=12s"
      track.should be_valid
    end
    it "should do all of the above at once" do
      track = Factory.build(:track, :url => "www.youtube.com/watch?v=FtbCx-i2Whg&feature=related")
      track.url.should == "http://www.youtube.com/watch?v=FtbCx-i2Whg"
      track.should be_valid
    end
    it "should disallow non-youtube hostnames" do
      track = Factory.build(:track, :url => "http://www.pornotube.com/watch?v=FtbCx-i2Whg")
      track.should_not be_valid
    end
  end
end
