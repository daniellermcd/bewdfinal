class AddPrivacyToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :private, :boolean, default: true
  end
end
