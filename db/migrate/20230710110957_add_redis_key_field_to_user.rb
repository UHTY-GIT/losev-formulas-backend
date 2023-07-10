class AddRedisKeyFieldToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :redis_key, :string, nil: false
  end
end
