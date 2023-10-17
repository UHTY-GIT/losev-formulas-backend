class UserPodcast < ApplicationRecord

  acts_as_api

  belongs_to :user
  belongs_to :podcast

end
