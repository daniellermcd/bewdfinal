class PhotosController < ApplicationController
  def create
    album_id = params[:album_id]
    album = Album.find album_id
    photobooth = "/albums/#{album_id}/photobooth"
    imageData = params[:image_data_url]['data:image/png;base64,'.length .. -1]

    photo = convert_to_png(imageData)

    photo_url = Photo.get_s3_url(album_id)
    album.photos.create url: photo_url
    redirect_to photobooth
  end

  private
  def convert_to_png(imageData)
    b = Base64.decode64(imageData)
    File.open('tmp_snapshot.png', 'wb') { |file| file.write b }
  end
end
