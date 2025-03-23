class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.integer :delivery_status

      t.timestamps
    end
  end
end
