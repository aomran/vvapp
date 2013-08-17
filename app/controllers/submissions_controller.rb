class SubmissionsController < ApplicationController
  before_action :set_locale_to_french
  before_action :check_user_login
  before_action :get_submission, except: [:new, :create]

  def new
    if @current_user.submissions.size == 1
      redirect_to profile_path, alert: "Vous avez déjà une soumission"
    else
      @submission = Submission.new
    end
  end

  def create
    @submission = @current_user.submissions.build(submission_params)

    if @submission.save
      redirect_to submission_path, notice: "Vos documents ont été reçus!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @submission.update(submission_params)
      redirect_to submission_path, notice: "Vos documents ont été mis à jour!"
    else
      render :edit
    end
  end

  def images
  end

  def complete
    @submission.complete = true
    @submission.save
    redirect_to profile_path, notice: 'Votre Soumission est complete'
  end

  private
  def get_submission
    @submission = @current_user.recent_submission
  end

  def submission_params
    params.require(:submission).permit(:cv, :artist_statement, :expo_project, :special_needs, :image_list, :images_attributes => [:image_file])
  end
end
