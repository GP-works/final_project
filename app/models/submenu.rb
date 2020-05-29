class Submenu < ApplicationRecord
  belongs_to :menu
  has_many :menuitems
  validates :name, presence: true
end
