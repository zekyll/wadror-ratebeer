class MembershipsController < ApplicationController
  def new
    if current_user.nil?
      redirect_to signin_path, notice:'Joining a club requires sign-in.'
    end
    @membership = Membership.new
  end

  def create
    membership_params = params.require(:membership).permit(:beer_club_id)
    @membership = Membership.new(membership_params)
    @membership.user = current_user

    if @membership.save
      redirect_to @membership.beer_club, notice: "Welcome to the club, #{@membership.user.username}!"
    else
      render action: 'new'
    end
  end

  def destroy
    membership = Membership.find(params[:id])
    membership.delete if membership.user == current_user
    redirect_to :back
  end
end
