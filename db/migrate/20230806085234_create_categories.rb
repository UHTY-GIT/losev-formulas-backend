class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name

      t.integer :category_type, default: 0

      t.timestamps
    end

    create_join_table :categories, :podcasts do |t|
      t.index :category_id
      t.index :podcast_id
      t.index [:category_id, :podcast_id], unique: true
    end
  end
end
