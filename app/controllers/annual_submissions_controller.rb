class AnnualSubmissionsController < ApplicationController

  def index

  end

  def new
    @annual_submission = AnnualSubmission.new
  end

  def create
    @annual_submission = AnnualSubmission.new(annual_submission_params)

    @annual_submission.save
    redirect_to annual_submissions_path, notice: "Your Submission has been received!"
  end

  private
  def annual_submission_params
    params.require(:annual_submission).permit(:cv, :artist_statement, :expo_project, :special_needs, :image_list)
  end
end
