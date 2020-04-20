class Menuitem < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  belongs_to :menu
  has_many :orderitems
end
