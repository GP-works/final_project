class AddImageUrlToMenuitems < ActiveRecord::Migration[6.0]
  def change
    add_column :menuitems, :image_url, :string
  end
end
