class Orderitem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menuitem
  def self.getqty
    select(:menu_item_name).group(:menu_item_name).having("count(*) >= 1").size
  end
end
