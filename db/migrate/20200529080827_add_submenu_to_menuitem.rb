class AddSubmenuToMenuitem < ActiveRecord::Migration[6.0]
  def change
    add_reference :menuitems, :submenu, null: false, foreign_key: true
  end
end
