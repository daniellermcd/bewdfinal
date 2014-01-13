class PhotosController < ApplicationController
  before_action :set_album_id

  def create
    album = Album.find @album_id
    photobooth = "/albums/#{@album_id}/photobooth"
    image_data = params[:image_data_url]['data:image/png;base64,'.length .. -1]

    # decode base64 data and save as a PNG
    convert_to_png(image_data)

    # send temporary image to S3 and return it's URL
    photo_url = Photo.get_s3_url(@album_id)

    # save photo record to database
    album.photos.create url: photo_url
    redirect_to photobooth
  end

  private
  def convert_to_png(image_data)
    b = Base64.decode64(image_data)
    File.open("tmp_snapshot_album_#{@album_id}.png", 'wb') { |file| file.write b }
  end

  def set_album_id
    @album_id = params[:album_id]
  end
end
