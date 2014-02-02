class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, length: { minimum: 1 }

  def to_s
    return name + " (" + brewery.name + ")";
  end
end
