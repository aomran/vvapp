class ImagesController < ApplicationController
  before_action :check_user_login

  def create
    @submission = Submission.find(params[:submission_id])
    @image = Image.new(image_params)
    @image.submission = @submission
    @image.save

    respond_to do |format|
      format.html { redirect_to @submission }
      format.js { }
    end
  end

  private
  def image_params
    params.require(:image).permit(:image_file)
  end
end
