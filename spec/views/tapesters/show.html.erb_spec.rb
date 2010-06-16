require File.dirname(__FILE__) + "/../../spec_helper"

describe 'tapesters/show' do
  include TapestersHelper

  shared_examples_for "a standard view" do
    it "should be successful" do
      response.should be_success
    end

    it "should be valid" do
      response.should be_valid_xhtml   
    end
  end

#   before do
#     assigns[:tapester] = Factory.build(:tapester)
#     render 'tapesters/show'
#   end
#   it_should_behave_like "a standard view"
end

