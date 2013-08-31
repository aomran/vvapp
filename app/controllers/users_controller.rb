class UsersController < ApplicationController
  before_action :set_locale_to_french
  before_action :check_user_login, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path, notice: "Vous avez réussi à créer votre compte d'utilisateur."
    else
      render :new
    end
  end

  def profile
    @submission = @current_user.recent_submission
  end

  def edit_profile
    @user = @current_user
  end

  def update_profile
    if @current_user.update(user_params)
      redirect_to profile_path, notice: "Vous avez réussi à éditer votre information d'utilisateur."
    else
      @user = @current_user
      render :edit_profile
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :gender, :email, :phone_number, :street_address, :city, :province, :postal_code, :country, :password, :password_confirmation)
  end
end
