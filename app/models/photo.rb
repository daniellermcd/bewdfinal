class Photo < ActiveRecord::Base
  belongs_to :album
  has_one :user, through: :album

  validates :url, presence: true

  def self.get_s3_url(album_id)
    bucket = 'pb_snaps'
    object_key = "#{album_id}/snapshot_#{Time.now.strftime("%Y-%m-%d-%H%M%S")}.png"
    public_url = "http://s3.amazonaws.com/#{bucket}/#{object_key}"

    AWS::S3::Base.establish_connection!(
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    )

    AWS::S3::S3Object.store(
      object_key,
      File.open("tmp_snapshot_album_#{album_id}.png"),
      bucket, access: :public_read
    )

    public_url
  end
end
