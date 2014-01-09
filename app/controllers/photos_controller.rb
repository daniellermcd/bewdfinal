class PhotosController < ApplicationController
  def create
    safe_photo_params = params.require(:photo).permit(:url, :album_id)
    @photo = Photo.new safe_photo_params

    if @photo.save
      redirect_to @photo
    else
      render :new
    end
  end

  def show
    @photo = Photo.find params[:id]
  end
end
