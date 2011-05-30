require 'fixer'

describe Fixer do
  let(:fixer) { Fixer.new(".") }
  before do
    Dir.stub(:[]).and_return(["_build", "matt", "lina"])
  end

  describe Fixer::Peep do
    
  end

  describe Fixer::Song do
    describe "#name" do
      fixture = {
        "01 Song - sub 3 mins.m4a" => "1.m4a",
        "1.m4a"                    => "1.m4a",
        "02 Funeral.mp3"           => "2.mp3"
      }
      fixture.each do |name, expected_name|
        it "should convert '#{name}' to '#{expected_name}'" do
          Fixer::Song.new(name, Fixer::Peep.new).name.should == expected_name
        end
      end
    end
  end
end
