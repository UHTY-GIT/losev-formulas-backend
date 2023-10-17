class User < ApplicationRecord

  acts_as_api
  has_secure_password

  has_many :ratings

  has_many :favorite_podcasts
  has_many :orders
  has_many :user_podcasts

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true


  has_attached_file :avatar,
                 url: '/uploads/users/avatars/:hash.:extension',
                 path: 'public/uploads/users/avatars/:hash.:extension',
                 hash_secret: 'secret_string_for_users_avatars'

  validates_attachment_content_type :avatar, content_type: IMAGE_CONTENT_TYPE


  api_accessible :simple do |t|
    t.add :id
    t.add :email
    t.add :name
    t.add :avatar_url, as: :avatar
  end

  api_accessible :index, extend: :simple do |t|
    t.add :created_at
    t.add :updated_at
  end

  def avatar_url
    avatar.file? ? avatar.url : nil
  end

end
