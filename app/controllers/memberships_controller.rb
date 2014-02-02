class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
  end

  def create
    membership_params = params.require(:membership).permit(:beer_club_id)
    @membership = Membership.new(membership_params)
    @membership.user = current_user

    if @membership.save
      redirect_to current_user, notice: "Successfully joined #{@membership.beer_club.name}."
    else
      render action: 'new'
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.delete
    redirect_to :back
  end
end
