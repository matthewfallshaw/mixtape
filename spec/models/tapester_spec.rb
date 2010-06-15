require File.join(File.dirname(__FILE__), "../spec_helper")

require "tapester.rb"

describe Tapester do
  describe "#tracks" do
    it "should start empty" do
      tapester = Factory.build(:tapester)
      tapester.tracks.should be_empty
    end
    describe "#populate" do
      describe "when empty" do
        before do
          @tapester = Factory.build(:tapester)
          3.times { Factory.create(:tape) }

          @tapester.tracks.populate
        end
        it "should make a new track for each Tape" do
          tapester_tapes = @tapester.tracks.collect {|track| track.tape }.sort {|a,b| a.name <=> b.name }
          tapes = Tape.all.sort {|a,b| a.name <=> b.name }
          tapester_tapes.should == tapes
        end
        it "should not make more tracks than required" do
          @tapester.tracks.size.should == Tape.all.size
        end
      end
      describe "when partially full" do
        before do
          @tapester = Factory.build(:tapester)
          3.times { tape = Factory.create(:tape); @tapester.tracks.build(:tape => tape) }
          2.times { Factory.create(:tape) }

          @tapester.tracks.populate
        end
        it "should make a new track for each Tape that doesn't yet have one" do
          tapester_tapes = @tapester.tracks.collect {|track| track.tape }.sort {|a,b| a.name <=> b.name }
          tapes = Tape.all.sort {|a,b| a.name <=> b.name }
          tapester_tapes.should == tapes
        end
        it "should not make more tracks than required" do
          @tapester.tracks.size.should == Tape.all.size
        end
      end
      describe "when full" do
        it "shouldn't change anything" do
          @tapester = Factory.build(:tapester)
          3.times { tape = Factory.create(:tape); @tapester.tracks.build(:tape => tape) }
          initial = @tapester.tracks.dup

          @tapester.tracks.populate

          @tapester.tracks.should == initial
        end
      end
    end
  end
end
