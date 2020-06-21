class Menu < ActiveRecord::Base
  has_many :menuitems
  has_many :submenus, dependent: :destroy
  validates :name, presence: true
end
