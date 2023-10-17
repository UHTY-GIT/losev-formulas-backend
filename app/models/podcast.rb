class Podcast < ApplicationRecord

  acts_as_api

  has_many :ratings

  has_and_belongs_to_many :categories, -> { distinct }
  has_many :favorite_podcasts
  has_many :orders
  has_many :user_podcasts

  validates :title, :description, presence: true

  scope :favorite_podcasts, -> {
    joins(:favorite_podcasts).distinct
  }

  scope :recommended, -> {
    where(recommended: true)
  }
  scope :in_top, -> {
    where(top: true)
  }

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



  api_accessible :simple do |t|
    t.add :id
    t.add :title
    t.add :description, as: :author
    t.add :price
    t.add :rating
    t.add :image_url
    t.add :audio_url
  end

  api_accessible :list, extend: :simple do |t|
    t.add :categories
  end

  def image_url
    image.file? ? image.url : nil
  end

  def audio_url
    audio.file? ? audio.url : nil
  end
end
