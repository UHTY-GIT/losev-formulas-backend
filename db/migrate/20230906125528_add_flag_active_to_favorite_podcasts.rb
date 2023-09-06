class AddFlagActiveToFavoritePodcasts < ActiveRecord::Migration[6.1]
  def change
    add_column :favorite_podcasts, :active, :boolean, default: true
  end
end
