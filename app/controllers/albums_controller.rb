class AlbumsController < ApplicationController
  force_ssl unless Rails.env.development?

  before_action :authenticate_user!
  before_filter :validate_user, only: [:show, :photobooth]

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

  def validate_user
    album_owner = Album.find(params[:id]).user
    redirect_to root_path unless current_user and current_user.id == album_owner.id
  end
end
