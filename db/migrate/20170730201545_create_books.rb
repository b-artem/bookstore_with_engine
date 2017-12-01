class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :price, precision: 7, scale: 2
      t.string :image_url
      t.integer :publication_year
      t.string :dimensions
      t.string :materials

      t.timestamps
    end
  end
end
