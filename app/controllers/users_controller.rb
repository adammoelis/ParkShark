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
    create_braintree_sub_merchant
  end

  def user_spots
    @user = User.find(params[:user_id])
    @spots = @user.spots
    @title = 'My Spots'
    @subtitle = 'View your listings below.'
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

  def create_braintree_sub_merchant
    split_name = current_user.name.split(" ")
    formatted_birthday = current_user.birthday.inspect.split(" ")
    phone = params[:user][:phone]
    phone.gsub!(/[^0-9A-Za-z]/, '')
    result = Braintree::MerchantAccount.create(
      :individual => {
        :first_name => Braintree::Test::MerchantAccount::Approve,
        :last_name => split_name[1],
        :email => current_user.email,
        :date_of_birth => "1981-11-19",
        :ssn => "456-45-4567",
        :address => {
          :street_address => params[:user][:street_address],
          :locality => params[:user][:city],
          :region => params[:user][:state],
          :postal_code => params[:user][:zip_code]
        }
      },
      :funding => {
        :destination => Braintree::MerchantAccount::FundingDestination::Bank,
        :email => current_user.email,
        :mobile_phone => phone,
        :account_number => params[:user][:account_number],
        :routing_number => params[:user][:routing_number]
      },
      :tos_accepted => true,
      :master_merchant_account_id => "student"
    )
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

  def get_client_token
    Braintree::ClientToken.generate
  end

end
