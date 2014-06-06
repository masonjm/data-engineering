class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many :purchases
  
  validates :description, presence: true
  validates :price, presence: true
  validates :merchant, presence: true
end
