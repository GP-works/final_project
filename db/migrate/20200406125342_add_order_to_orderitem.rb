class AddOrderToOrderitem < ActiveRecord::Migration[6.0]
  def change
    add_reference :orderitems, :order, null: false, foreign_key: true
  end
end
