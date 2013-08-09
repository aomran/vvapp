class UsersController < ApplicationController

  before_action :check_user_login, only: [:profile, :edit_profile]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    session[:user_id] = @user.id
    redirect_to profile_path
  end

  # def show
  #   @user = User.find(params[:id])
  # end

  def profile
  end

  def edit_profile
    @user = @current_user
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :email, :phone_number, :street_address, :city, :province, :postal_code, :country, :password, :password_confirmation)
  end
end
