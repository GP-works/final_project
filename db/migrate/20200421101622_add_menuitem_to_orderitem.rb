class AddMenuitemToOrderitem < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :menuitem_id, :bigint
  end
end
