class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    sum = 0;
    ratings.each { |r| sum += r.score }
    return sum.to_f / ratings.count
  end
end
