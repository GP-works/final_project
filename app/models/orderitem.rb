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
      .pluck("menu_item_name,sum(menu_item_price),count(*)")
  end
  def self.getreports(from_date, to_date)
    sum_array = all.getsum(from_date, to_date)
    total_sum = sum_array.sum { |menu_item, menu_item_price, qty| menu_item_price }
    total_qty = sum_array.sum { |menu_item, menu_item_price, qty| qty }
    if total_qty == 0
      total_sum = 1
      total_qty = 1
    end
    percent_hash = {}
    sum_array.each { |menu_item_name, menu_item_price, qty|
      percent_hash[menu_item_name.to_sym] = { sum: menu_item_price,
                                              percent_price: ((menu_item_price * 100) / total_sum),
                                              qty: qty,
                                              percent_qty: ((qty * 100) / total_qty) }
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
