class FavoritePodcast < ApplicationRecord

  acts_as_api

  belongs_to :user
  belongs_to :podcast

  delegate :is_active?, to: :podcast

  def is_active?
    active
  end

end
