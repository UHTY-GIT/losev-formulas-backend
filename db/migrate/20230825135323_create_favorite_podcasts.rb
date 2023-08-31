class CreateFavoritePodcasts < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_podcasts do |t|
      t.references :podcast
      t.references :user

      t.timestamps
    end
  end
end
