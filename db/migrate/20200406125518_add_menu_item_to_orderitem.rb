class AddMenuItemToOrderitem < ActiveRecord::Migration[6.0]
  def change
    add_reference :orderitems, :menuitem, null: false, foreign_key: true
  end
end
