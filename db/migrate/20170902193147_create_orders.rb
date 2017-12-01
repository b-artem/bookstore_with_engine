class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :number
      t.datetime :completed_at
      t.string :state
      t.references :user, foreign_key: true
      t.references :billing_address, references: :addresses
      t.references :shipping_address, references: :addresses
      t.references :shipping_method, foreign_key: true

      t.timestamps
    end
    add_index :orders, :number
  end
end
