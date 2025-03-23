class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock, null: false, default: 0
      t.string :fit_type

      t.timestamps
    end
  end
end
