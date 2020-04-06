class CreateOrderitems < ActiveRecord::Migration[6.0]
  def change
    create_table :orderitems do |t|
      t.string :menu_item_name
      t.float :menu_item_price
    end
  end
end
