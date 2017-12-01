class AddUseBillingAddressToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :use_billing_address_as_shipping, :boolean, default: false
  end
end
