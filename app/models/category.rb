class Category < ApplicationRecord

  acts_as_api

  has_and_belongs_to_many :podcasts, -> { distinct }

  enum category_type: %i[free paid]

end
