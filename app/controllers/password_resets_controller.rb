class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    @user.send_password_reset if @user
    redirect_to login_path, notice: 'Courriel envoyé avec des instructions pour mettre à jour votre mot de passe'
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Permission pour changer mot de passe est expiré."
    elsif @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Mot de passe mis à jour."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
