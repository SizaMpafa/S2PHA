class AddPhoneNumberAndAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :address, :string
  end
end
