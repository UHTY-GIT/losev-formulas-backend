class CreateUserPodcasts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_podcasts do |t|
      t.references :user
      t.references :podcast

      t.timestamps
    end
  end
end
