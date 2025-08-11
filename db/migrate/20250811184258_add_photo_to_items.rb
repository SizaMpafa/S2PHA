class AddPhotoToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :photo, :string
  end
end
