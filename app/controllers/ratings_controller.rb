class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
  end

  def create
    rating_params = params.require(:rating).permit(:score, :beer_id)
    beer = Beer.find(rating_params[:beer_id]) # throws if beer id not found
    beer.ratings.create rating_params
    redirect_to ratings_path
  end
end