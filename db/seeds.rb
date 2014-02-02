# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

br1 = Brewery.create name: "Koff", year: 1897
br2 = Brewery.create name: "Malmgard", year: 2001
br3 = Brewery.create name: "Weihenstephaner", year: 1042

b1 = br1.beers.create name: "Iso 3", style: "Lager"
b2 = br1.beers.create name: "Karhu", style: "Lager"
b3 = br1.beers.create name: "Tuplahumala", style: "Lager"
b4 = br2.beers.create name: "Huvila Pale Ale", style: "Pale Ale"
b5 = br2.beers.create name: "X Porter", style: "Porter"
b6 = br3.beers.create name: "Hefezeizen", style: "Weizen"
b7 = br3.beers.create name: "Helles", style: "Lager"

c1 = BeerClub.create name: "Club 1", founded: 2009, city: "Helsinki"
c2 = BeerClub.create name: "Club 2", founded: 2014, city: "Vantaa"

u1 = User.create username: "User1", password: "User1", password_confirmation: "User1"
u2 = User.create username: "User2", password: "User2", password_confirmation: "User2"

c1.members << u1
c1.members << u2
c2.members << u1

u1.ratings.create score: 10, beer_id: b1.id
u1.ratings.create score: 11, beer_id: b2.id
u1.ratings.create score: 12, beer_id: b3.id
u1.ratings.create score: 13, beer_id: b4.id
u1.ratings.create score: 14, beer_id: b5.id
u1.ratings.create score: 15, beer_id: b6.id
u1.ratings.create score: 16, beer_id: b7.id

u2.ratings.create score: 20, beer_id: b1.id
u2.ratings.create score: 22, beer_id: b2.id
u2.ratings.create score: 24, beer_id: b3.id
u2.ratings.create score: 26, beer_id: b4.id
u2.ratings.create score: 28, beer_id: b5.id
u2.ratings.create score: 30, beer_id: b6.id
u2.ratings.create score: 32, beer_id: b7.id
