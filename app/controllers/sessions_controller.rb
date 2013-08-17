class SessionsController < ApplicationController
  before_action :set_locale_to_french
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path, notice: "Vous êtes connecté(e) comme #{user.email}"
    else
      flash.now.alert = "Courriel ou mot de passe est invalide."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Vous êtes désormais déconnecté(e)!'
  end

end
