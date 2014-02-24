class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships


  validates :username, uniqueness: true, length: { in: 3..15 }
  validates :password, length: { minimum: 4 }
  validate :password_must_contain_capital_letters
  validate :password_must_contain_digits

  def self.most_active(n)
    User.all.sort_by{ |u| -u.ratings.length }[0..n-1]
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    styles = {}
    ratings.each do |r|
      if not styles.key? r.beer.style
        styles[r.beer.style] = Struct.new(:count, :sum).new(0, 0)
      end
      styles[r.beer.style].count += 1
      styles[r.beer.style].sum += r.score
    end
    styles.sort_by{ |k, v| v.sum.to_f / v.count }.last[0]
  end

  def favorite_brewery
    return nil if ratings.empty?
    breweries = {}
    ratings.each do |r|
      if not breweries.key? r.beer.brewery
        breweries[r.beer.brewery] = Struct.new(:count, :sum).new(0, 0)
      end
      breweries[r.beer.brewery].count += 1
      breweries[r.beer.brewery].sum += r.score
    end
    breweries.sort_by{ |k, v| v.sum.to_f / v.count }.last[0]
  end

  def unjoined_clubs
    BeerClub.all.select { |c| not c.members.include? self }
  end

private
  def password_must_contain_capital_letters
    if /[ABCDEFGHIJKLMNOPQRSTUVWXYZ]/.match(password) == nil
      errors.add(:password, "must contain at least one capital letter A-Z")
    end
  end

  def password_must_contain_digits
    if /[0123456789]/.match(password) == nil
      errors.add(:password, "must contain at least one digit 0-9")
    end
  end


end
