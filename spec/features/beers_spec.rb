require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Psw1")
  end

  it "is saved when name is non-empty" do
    visit new_beer_path

    fill_in('beer[name]', with:'15')
    select('Lager', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(1).to(2)

    expect(brewery.beers.count).to eq(2)
  end

  it "is not saved if name is empty" do
    visit new_beer_path

    fill_in('beer[name]', with:'')
    select('Lager', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    click_button "Create Beer"

    Beer.count.should == 1
    expect(current_path).to eq(beers_path)
  end
end