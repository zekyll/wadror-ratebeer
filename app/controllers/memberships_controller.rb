class MembershipsController < ApplicationController
  def new
    @beer_clubs = BeerClub.all
    @membership = Membership.new
  end

  def create
    membership_params = params.require(:membership).permit(:beer_club_id)
    @membership = Membership.new(membership_params)

    if @membership.save
      current_user.memberships << @membership
      redirect_to current_user, notice: "Successfully joined #{@membership.beer_club.name}."
    else
      @beer_clubs = BeerClub.all
      render action: 'new'
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.delete
    redirect_to :back
  end
end
