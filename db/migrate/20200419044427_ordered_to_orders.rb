class OrderedToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :ordered, :boolean
  end
end
