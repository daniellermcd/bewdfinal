class Photo < ActiveRecord::Base
  belongs_to :album
  has_one :user, through: :album

  validates :url, presence: true
end
