class AddAvailableToMenuitem < ActiveRecord::Migration[6.0]
  def change
    add_column :menuitems, :available, :boolean
  end
end
