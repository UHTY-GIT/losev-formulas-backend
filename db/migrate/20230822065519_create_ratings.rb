class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :podcast

      t.integer :rating_value

      t.timestamps
    end
  end
end
