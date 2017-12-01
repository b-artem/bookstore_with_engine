class RemoveAddressesFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_reference :orders, :billing_address
    remove_reference :orders, :shipping_address
  end
end
