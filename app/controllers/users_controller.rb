class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:update, :edit, :delete]
  before_action :find_user, only: [:show, :update, :edit]
  before_action :correct_user?, only: [:edit]

  def index
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 30)
  end

  def show
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile was updated successfully!'
      redirect_to user_path(@user)
    else
      flash[:error] = 'Sorry, something went wrong when updating your profile.'
      render 'users/edit'
    end
  end

  def edit
    @token = get_client_token
  end

  def purchase_information
    @user = User.find(current_user.id)
    @token = get_client_token
  end

  def update_purchase_information
    result = User.create_braintree_sub_merchant(params, current_user)
    if result.success?
      current_user.braintree_merchant_id = result.merchant_account.id
      current_user.save
      flash[:notice] = 'Your profile was updated successfully!'
      redirect_to new_spot_path
    else
      flash[:notice] = result.message
      redirect_to purchase_information_path(current_user.id)
    end
  end

  def user_spots
    @user = User.find(params[:user_id])
    @spots = @user.spots.page(params[:page]).per_page(12)
<<<<<<< HEAD
    @title = 'My Spots'
    @subtitle = 'View your listings below.'
=======
>>>>>>> be009fae210f64b7a4e3b3f77f6306ac0ccc2aa7
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :gender, :email, :phone,
                                 :location, :bio, :birthday, :street_address,
                                 :city, :state, :zip_code, :provider, :uid)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def correct_user?
    redirect_to user_path(current_user) unless current_user?
  end

  def get_client_token
    Braintree::ClientToken.generate
  end

  def get_client_token
    Braintree::ClientToken.generate
  end
end
