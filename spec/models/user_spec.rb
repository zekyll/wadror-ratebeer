require 'spec_helper'

describe User do

  def create_beer_with_rating(score, user, attr = nil)

    beer = attr == nil ? FactoryGirl.create(:beer) : FactoryGirl.create(:beer, attr)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user, attr)
    scores.each do |score|
      create_beer_with_rating(score, user, attr)
    end
  end

  it "has the username set correctly" do
    user = User.new username:"Pekka"
    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    user.valid?.should == false
    User.count.should == 0
  end

  it "is not saved if password is shorter than 4 characters" do
    user = User.create username: "Pekka", password: "Ps1", password_confirmation: "Ps1"
    user.valid?.should == false
    User.count.should == 0
  end

  it "is not saved if password contains no digits" do
    user = User.create username: "Pekka", password: "Pswd", password_confirmation: "Pswd"
    user.valid?.should == false
    User.count.should == 0
  end

  it "is not saved if password contains no uppercase letters" do
    user = User.create username: "Pekka", password: "psw1", password_confirmation: "psw1"
    user.valid?.should == false
    User.count.should == 0
  end

  describe "favorite beer" do
    let(:user){ FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      user.favorite_beer.should == nil
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)
      user.favorite_beer.should == beer
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user, nil)
      best = create_beer_with_rating(25, user)
      user.favorite_beer.should == best
    end
  end

  describe "favorite style" do
    let(:user){ FactoryGirl.create(:user) }

    it "without ratings does not have one" do
      user.favorite_style.should == nil
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)
      user.favorite_style.should == beer.style
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(2, 3, 4, user, style: "Style1")
      create_beers_with_ratings(3, 5, user, style: "Style2")
      create_beers_with_ratings(2, 1, 4, 7, user, style: "Style3")
      user.favorite_style.should == "Style2"
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryGirl.create(:user) }

    it "without ratings does not have one" do
      user.favorite_style.should == nil
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)
      user.favorite_style.should == beer.style
    end

    it "is the one with highest rating if several rated" do
      br1 = FactoryGirl.create(:brewery, name:"Br1")
      br2 = FactoryGirl.create(:brewery, name:"Br2")
      br3 = FactoryGirl.create(:brewery, name:"Br3")
      create_beers_with_ratings(2, 3, 4, user, brewery: br1)
      create_beers_with_ratings(3, 5, user, brewery: br2)
      create_beers_with_ratings(2, 1, 4, 7, user, brewery: br3)
      user.favorite_brewery.should == br2
    end
  end

  describe "with a proper password" do
    let(:user) { FactoryGirl.create(:user) }

    it "is saved" do
      user.valid?.should == true
      User.count.should == 1
    end

    it "and two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      user.ratings.count.should == 2
      user.average_rating.should == 15.0
    end
  end
end
