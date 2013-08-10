class ImagesController < ApplicationController
  before_action :check_user_login

  def create
    submission = Submission.find(params[:submission_id])
    image = Image.new(image_params)
    image.submission = submission
    image.save

    redirect_to submission
  end

  private
  def image_params
    params.require(:image).permit(:image_file)
  end
end
