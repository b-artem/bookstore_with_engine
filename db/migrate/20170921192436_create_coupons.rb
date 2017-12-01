class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.decimal :discount, precision: 4, scale: 1
      t.date :valid_until

      t.timestamps
    end
  end
end
