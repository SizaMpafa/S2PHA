class CreateItemVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :item_variants do |t|
      t.references :item, null: false, foreign_key: true
      t.string :size, null: false
      t.string :color, null: false
      t.integer :stock, null: false, default: 0

      t.timestamps
    end
  end
end
