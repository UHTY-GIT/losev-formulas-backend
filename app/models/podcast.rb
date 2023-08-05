class Podcast < ApplicationRecord

  acts_as_api

  validates :title, :description, presence: true

  has_attached_file :image,
                    url: '/uploads/podcasts/images/:hash.:extension',
                    path: 'public/uploads/podcasts/images/:hash.:extension',
                    hash_secret: 'secret_string_for_podcasts_images'

  validates_attachment_content_type :image, content_type: IMAGE_CONTENT_TYPE

  has_attached_file :audio,
                    url: '/uploads/podcasts/audios/:hash.:extension',
                    path: 'public/uploads/podcasts/audios/:hash.:extension',
                    hash_secret: 'secret_string_for_podcasts_audios'

  validates_attachment_content_type :audio, content_type: AUDIO_CONTENT_TYPE



  def image_url
    image.file? ? image.url : nil
  end
end
