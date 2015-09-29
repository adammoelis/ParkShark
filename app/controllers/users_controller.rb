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
    if @user.update(params[:user])
      # success
    else
      # error handling
    end
  end

  def edit
    @user
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :email, :phone, :location)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
