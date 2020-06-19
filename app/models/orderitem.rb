class Orderitem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menuitem
  def self.getqty
    select(:menu_item_name).group(:menu_item_name).having("count(*) >= 1").size
  end
  def self.qty(id)
    where("menuitem_id = ?", id).count
  end
  def self.item(id)
    find_by("menuitem_id = ?", id)
  end
  def self.notexist
    notavailable_elements = all.select { |orderitem| (Menuitem.available.exists?(orderitem.menuitem_id) == false) }
                               .map { |orderitem| orderitem.menu_item_name }.uniq
  end
end
