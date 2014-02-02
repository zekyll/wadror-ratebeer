class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042, only_integer: true },
            presence: true
  validate :year_cannot_greater_than_current_year

  def print_report
    puts self.name
    puts "established at year #{self.year}"
    puts "number of beers #{self.beers.count}"
    puts "number of ratings #{self.ratings.count}"
  end

  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

  def year_cannot_greater_than_current_year
    if year.is_a? Fixnum and year > Time.now.year
      errors.add(:year, "cannot be greater than current year")
    end
  end
end
