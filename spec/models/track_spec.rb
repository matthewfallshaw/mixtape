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

    it "should refuse duplicate base_urls" do
      Factory.create(:track, :url => "youtube.com/watch?v=sISJkCJ7Jto&feature=related#t=12s")
      track = Factory.build(:track, :url => "youtube.com/watch?v=sISJkCJ7Jto#t=11s")
      track.valid?
      track.errors[:url].join.should match(/OMG/)
    end
  end
  
  describe "#base_url" do
    it "should be #url without any fluff on the end" do
      track = Factory.build(:track, :url => "www.youtube.com/watch?v=FtbCx-i2Whg&feature=related#t=12s")
      track.base_url.should == "http://www.youtube.com/watch?v=FtbCx-i2Whg"
    end
  end
end
