class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    rating_params = params.require(:rating).permit(:score, :beer_id)
    beer = Beer.find(rating_params[:beer_id]) # throws if beer id not found
    rating = beer.ratings.create rating_params
    session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end