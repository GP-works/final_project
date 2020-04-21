class RemoveMenuitemFromOrderitem < ActiveRecord::Migration[6.0]
  def change
    remove_reference :orderitems, :menuitem, null: false, foreign_key: true
  end
end
