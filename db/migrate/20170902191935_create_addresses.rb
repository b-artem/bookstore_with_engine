class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :addresses, :type
  end
end
