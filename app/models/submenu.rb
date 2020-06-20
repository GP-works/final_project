class Submenu < ApplicationRecord
  belongs_to :menu
  has_many :menuitems, dependent: :destroy
  validates :name, presence: true
end
