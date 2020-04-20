class Menuitem < ActiveRecord::Base
  belongs_to :menu
  has_many :orderitems
end
