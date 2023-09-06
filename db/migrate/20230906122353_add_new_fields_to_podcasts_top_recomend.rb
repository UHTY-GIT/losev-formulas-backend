class AddNewFieldsToPodcastsTopRecomend < ActiveRecord::Migration[6.1]
  def change
    add_column :podcasts, :top, :boolean, default: false
    add_column :podcasts, :recommended, :boolean, default: false
  end
end
