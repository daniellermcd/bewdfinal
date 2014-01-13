class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = current_user.albums
  end

  def photobooth
    @album = album
    @username = username
  end

  def show
    @album = album
    @username = username
    @album_photos = @album.photos
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

  private
  def username
    @album.user.email[/[^@]+/]
  end

  def album
    Album.find params[:id]
  end
end
