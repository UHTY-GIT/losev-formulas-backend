class Category < ApplicationRecord

  acts_as_api

  has_and_belongs_to_many :podcasts, -> { distinct }

  enum category_type: %i[free paid]

  api_accessible :list do |t|
    t.add :name
    t.add :category_type
  end

end
