class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    render nothing: true
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :email, :phone_number, :street_address, :city, :province, :postal_code, :country)
  end
end
