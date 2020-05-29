class CreateSubmenus < ActiveRecord::Migration[6.0]
  def change
    create_table :submenus do |t|
      t.string :name

      t.timestamps
    end
  end
end
