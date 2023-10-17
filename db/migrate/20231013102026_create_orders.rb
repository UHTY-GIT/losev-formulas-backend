class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.references :user
      t.references :podcast

      t.string :uuid

      t.integer :status, default: 0
      t.integer :payment_method
      t.integer :amount

      t.timestamps
    end
  end
end
