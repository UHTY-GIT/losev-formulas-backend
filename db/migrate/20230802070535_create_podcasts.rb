class CreatePodcasts < ActiveRecord::Migration[6.1]
  def change
    create_table :podcasts do |t|
      t.integer :position, default: 0

      t.string :title
      t.string :description

      t.attachment :image
      t.attachment :audio

      t.timestamps
    end
  end
end
