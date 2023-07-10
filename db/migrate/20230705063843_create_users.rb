class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|

      t.attachment :avatar

      t.string :name
      t.string :email, nil: false
      t.string :password_digest, nil: false

      t.index :email
      t.timestamps
    end
  end
end
