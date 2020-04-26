class Menuitem < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  belongs_to :menu
  has_many :orderitems

  def image
    default_image = "default.jpeg"
    return default_image if self.image_url == "" || self.image_url == nil
    self.image_url
  end

  def description_method
    return "tasty #{self.name}" if self.description == "" || self.description == nil
    self.description
  end
end
