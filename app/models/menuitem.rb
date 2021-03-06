class Menuitem < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :description, length: { maximum: 33 }
  belongs_to :menu
  belongs_to :submenu
  has_many :orderitems

  def image
    default_image = "https://res.cloudinary.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,w_520,h_520/rng/md/carousel/production/awurei8ypqkafoqay9ym"
    self.image_url.presence || default_image
  end

  def description_method
    return "tasty #{self.name}" if self.description == "" || self.description == nil
    self.description
  end

  def self.available
    where("available = ?", true)
  end
end
