class AlbumsController < ApplicationController
  force_ssl unless Rails.env.development?

  before_action :set_album, except: [:new, :create, :index]
  before_action :set_username, only: [:photobooth, :show]
  before_action :authenticate_user!, except: :show

  before_filter :validate_user_view_privileges, only: :show
  before_filter :validate_user_photobooth_privileges, only: :photobooth

  def create
    @album = current_user.albums.new safe_album_params
    @album.save ? redirect_to("/albums/#{@album.id}/photobooth") : render(:new)
  end

  def edit
  end

  def index
    @albums = current_user.albums
  end

  def new
    @album = Album.new
  end

  def photobooth
  end

  def share
  end

  def show
    @album_photos = @album.photos.reverse.map { |photo| photo.url }
  end

  def update
    @album.update safe_album_params
    redirect_to @album
  end

  private
  def set_username
    @username = @album.user.email[/[^@]+/]
  end

  def set_album
    @album = Album.find params[:id]
  end

  def album_private?
    @album.private
  end

  def validate_user_view_privileges
    album_owner_id = @album.user.id
    if album_private?
      redirect_to(root_path, alert: 'You don\'t have permission to view this album.') unless current_user and current_user.id == album_owner_id
    end
  end

  def validate_user_photobooth_privileges
    album_owner_id = @album.user.id
    redirect_to root_path unless current_user and current_user.id == album_owner_id
  end

  def safe_album_params
    safe_album_params = params.require(:album).permit(:title, :private)
  end
end
