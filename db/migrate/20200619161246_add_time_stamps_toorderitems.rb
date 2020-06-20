class AddTimeStampsToorderitems < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :created_at, :datetime
    add_column :orderitems, :updated_at, :datetime
  end
end
