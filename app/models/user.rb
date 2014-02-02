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

  def unjoined_clubs
    BeerClub.all.select { |c| not c.members.include? self }
  end

  def password_must_contain_capital_letters
    if /[ABCDEFGHIJKLMNOPQRSTUVWXYZ]/.match(password) == nil
      errors.add(:year, "must contain at least one capital letter A-Z")
    end
  end

  def password_must_contain_digits
    if /[0123456789]/.match(password) == nil
      errors.add(:year, "must contain at least one digit 0-9")
    end
  end
end
