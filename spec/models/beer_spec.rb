require 'spec_helper'

describe Beer do

  it "with proper style and name is saved" do
    beer = Beer.create name: "Beer1", style: FactoryGirl.create(:style),
                       brewery: FactoryGirl.create(:brewery)
    beer.valid?.should == true
    Beer.count.should == 1
  end

  it "without name is not saved" do
    beer = Beer.create style: FactoryGirl.create(:style)
    beer.valid?.should == false
    Beer.count.should == 0
  end

  it "without style is not saved" do
    beer = Beer.create name: "Beer1"
    beer.valid?.should == false
    Beer.count.should == 0
  end

end
