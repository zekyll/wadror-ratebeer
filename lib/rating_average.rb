module RatingAverage
  def average_rating
    return ratings.average(:score).to_f;
  end
end