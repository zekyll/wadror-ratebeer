require 'spec_helper'

describe User do
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

  describe "with a proper password" do
    let(:user) { User.create username: "Pekka", password: "Psw1", password_confirmation: "Psw1" }

    it "is saved" do
      user.valid?.should == true
      User.count.should == 1
    end

    it "and two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      user.ratings.count.should == 2
      user.average_rating.should == 15.0
    end
  end
end
