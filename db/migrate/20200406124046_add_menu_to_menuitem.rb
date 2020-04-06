class AddMenuToMenuitem < ActiveRecord::Migration[6.0]
  def change
    add_reference :menuitems, :menu, null: false, foreign_key: true
  end
end
