class Orderitem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menuitem
  def self.getqty
    select(:menu_item_name).group(:menu_item_name).having("count(*) >= 1").size
  end
  def self.getsum(from_date, to_date)
    all.where("created_at >= ? AND created_at <= ? ", from_date, to_date)
      .select(:menu_item_name)
      .group(:menu_item_name)
      .sum(:menu_item_price)
  end
  def self.getreports(from_date, to_date)
    sum_hash = all.getsum(from_date, to_date)
    total_sum = sum_hash.sum { |menu_item, menu_item_price| menu_item_price }
    percent_hash = {}
    sum_hash.each { |menu_item_name, menu_item_price|
      percent_hash[menu_item_name.to_sym] = { sum: menu_item_price, percent: ((menu_item_price * 100) / total_sum) }
    }
    percent_hash
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
  def self.available
    all.select { |orderitem| (Menuitem.available.exists?(orderitem.menuitem_id) == true) }
      .map { |orderitem| orderitem }
  end
end
