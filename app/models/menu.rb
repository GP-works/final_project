class Menu < ActiveRecord::Base
  has_many :menuitems
  has_many :submenus
  validates :name, presence: true
end
