class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    sum = ratings.inject(0) { |sum, r| sum + r.score }
    return sum.to_f / ratings.count
  end

  def to_s
    return name + " (" + brewery.name + ")";
  end
end
