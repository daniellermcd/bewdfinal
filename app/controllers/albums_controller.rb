class AlbumsController < ApplicationController
  def show
    @album = Album.find params[:id]
    @album_photos = @album.photos
    @username = @album.user.email[/[^@]+/]
  end

  def new
    @album = Album.new
  end

  def create
    safe_album_params = params.require(:album).permit(:title)
    @album = current_user.albums.new safe_album_params

    if @album.save
      redirect_to @album
    else
      render :new
    end
  end
end
