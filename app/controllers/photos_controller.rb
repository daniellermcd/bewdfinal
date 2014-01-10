class PhotosController < ApplicationController
  def create
    @album = Album.find params[:album_id]
    @album.photos.create url: params[:photo_url]
    redirect_to @album
  end
end
