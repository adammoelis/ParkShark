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
      create_braintree_user
      flash[:notice] = 'Your profile was updated successfully!'
    else
      flash[:error] = 'Sorry, something went wrong when updating your profile.'
    end
    redirect_to user_path(@user)
  end

  def edit
    @token = get_client_token
  end

  def user_spots
    @user = User.find(params[:user_id])
    @spots = @user.spots
    @title = 'My Spots'
    @subtitle = 'View your listings below.'
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :name, :gender, :email, :phone, :location, :bio, :birthday)
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

  def create_braintree_user
    split_name = params[:user][:name].split(" ")
    result = Braintree::Customer.create(
      :first_name => split_name[0],
      :last_name => split_name[1],
      :payment_method_nonce => params[:payment_method_nonce]
    )
    if result.success?
      current_user.brain_tree_id = result.customer.id
      current_user.payment_token = result.customer.payment_methods[0].token
      current_user.save
      binding.pry
    else
      flash[:notice] = result.messages
      redirect_to edit_user_path(current_user.id)
    end
  end

end
