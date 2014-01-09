class HomeController < ApplicationController
  def index
    if user_signed_in?
      @albums = current_user.albums
    end
  end
end
