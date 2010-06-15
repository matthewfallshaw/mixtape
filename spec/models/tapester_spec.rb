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

  describe "#orphan" do
    it "should be true when no encrypted_password and no reset_password_token" do
      tapester = Factory.build(:tapester, :password => nil,
                               :encrypted_password => nil, :reset_password_token => nil)
      tapester.orphan?.should == true
    end
    it "should be false when reset_password_token exists" do
      tapester = Factory.build(:tapester, :password => nil,
                               :encrypted_password => nil, :reset_password_token => "token")
      tapester.orphan?.should == false
    end
    it "should be false when encrypted_password exists" do
      tapester = Factory.build(:tapester, :password => nil,
                               :encrypted_password => "encryptedpasswd", :reset_password_token => nil)
      tapester.orphan?.should == false
    end
  end
end
