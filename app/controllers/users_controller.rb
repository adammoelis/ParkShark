class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :update, :edit]

  def index
    @users = User.all
  end

  def show
    @user
  end

  def update
    if @user.update(user_params)
      # success
    else
      # error handling
    end
  end

  def edit
    @user
  end

  def user_spots
    @user = User.find(params[:user_id])
    @spots = @user.spots
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :gender, :email, :phone, :location)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
