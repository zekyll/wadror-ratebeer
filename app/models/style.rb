class Style < ActiveRecord::Base
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.top(n)
    Style.all.sort_by{ |b| -(b.average_rating||0) }[0..n-1]
  end

end
