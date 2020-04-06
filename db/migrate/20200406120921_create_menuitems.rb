class CreateMenuitems < ActiveRecord::Migration[6.0]
  def change
    create_table :menuitems do |t|
      t.string :name
      t.string :description
      t.float :price
    end
  end
end
