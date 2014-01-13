class AlbumsController < ApplicationController
  force_ssl unless Rails.env.development?

  before_action :set_album, only: [:photobooth, :show, :edit, :update]
  before_action :set_username, only: [:photobooth, :show]
  before_action :authenticate_user!
  before_filter :validate_user, only: [:show, :photobooth]

  def index
    @albums = current_user.albums
  end

  def photobooth
  end

  def show
    @album_photos = @album.photos
  end

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.new safe_album_params

    if @album.save
      redirect_to @album
    else
      render :new
    end
  end

  def edit
  end

  def update
    @album.update safe_album_params
    redirect_to @album
  end

  private
  def set_username
    @album.user.email[/[^@]+/]
  end

  def set_album
    @album = Album.find params[:id]
  end

  def validate_user
    album_owner = Album.find(params[:id]).user
    redirect_to root_path unless current_user and current_user.id == album_owner.id
  end

  def safe_album_params
    safe_album_params = params.require(:album).permit(:title)
  end
end
