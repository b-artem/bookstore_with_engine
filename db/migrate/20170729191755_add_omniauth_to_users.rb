class AddOmniauthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :omniauth_provider, :string
    add_column :users, :omniauth_uid, :string
    add_column :users, :image_url, :string
    add_index :users, :omniauth_provider
    add_index :users, :omniauth_uid
    add_index :users, [:omniauth_provider, :omniauth_uid], unique: true
  end
end
