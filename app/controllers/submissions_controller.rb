class SubmissionsController < ApplicationController

  before_action :check_user_login

  def index
    @submissions = Submission.all
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def new
    @user = User.find(session[:user_id])
    if @user.submissions.size == 1
      redirect_to profile_path, alert: "Vous avez déjà une soumission"
    else
      @submission = Submission.new
      @submission.images.new
    end
  end

  def create
    @user = User.find(session[:user_id])
    @submission = @user.submissions.build(submission_params)

    if @submission.save
      redirect_to submission_path(@submission), notice: "Vos documents ont été reçus!"
    else
      render :new
    end
  end

  def edit
    @submission = Submission.find(params[:id])
  end

  def update
    @submission = Submission.find(params[:id])
    @submission.update(submission_params)
    redirect_to @submission
  end

  def images
    @submission = Submission.find(params[:id])
  end

  def complete
    @submission = Submission.find(params[:id])
    @submission.complete = true
    @submission.save
    redirect_to profile_path, notice: 'Votre Soumission est complete'
  end

  private
  def submission_params
    params.require(:submission).permit(:cv, :artist_statement, :expo_project, :special_needs, :image_list, :images_attributes => [:image_file])
  end
end
