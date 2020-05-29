class Submenu < ApplicationRecord
  belongs_to :menu
  validates :name, presence: true
end
