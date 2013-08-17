class ImagesController < ApplicationController
  before_action :check_user_login
  before_action :get_submission

  def create
    @image = Image.new(image_params)
    @image.submission = @submission
    @image.save

    respond_to do |format|
      format.html { redirect_to submission_images_path }
      format.js { }
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to submission_images_path
  end

  private
  def get_submission
    @submission = @current_user.recent_submission
  end
  def image_params
    params.require(:image).permit(:image_file)
  end
end
