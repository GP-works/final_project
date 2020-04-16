class Order < ActiveRecord::Base
  has_many :orderitems
  belongs_to :user
end
