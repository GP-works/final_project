class AddMenuRefToSubmenu < ActiveRecord::Migration[6.0]
  def change
    add_reference :submenus, :menu, null: false, foreign_key: true
  end
end
