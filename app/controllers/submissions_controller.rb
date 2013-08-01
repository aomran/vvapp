class SubmissionsController < ApplicationController

  before_action :check_user_login, only: [:new, :create]

  def index
    @submissions = Submission.all
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def new
    @submission = Submission.new
  end

  def create
    @user = User.find(session[:user_id])
    @submission = @user.submissions.build(submission_params)

    @submission.save
    redirect_to submissions_path, notice: "Your Submission has been received!"
  end

  private
  def submission_params
    params.require(:submission).permit(:cv, :artist_statement, :expo_project, :special_needs, :image_list)
  end
end
