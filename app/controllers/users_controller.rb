class UsersController < ApplicationController
  before_action :authenticate_user!, :find_user

  def user_spots
    @spots = @user.spots
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
