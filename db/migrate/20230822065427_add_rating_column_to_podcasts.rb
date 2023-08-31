class AddRatingColumnToPodcasts < ActiveRecord::Migration[6.1]
  def change
    add_column :podcasts, :rating, :integer, default: 0
  end
end
