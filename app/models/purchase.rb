class Purchase < ActiveRecord::Base
  belongs_to :purchaser
  belongs_to :item
  
  validates :quantity, presence: true
  validates :purchaser, presence: true
  validates :item, presence: true

  def total
    quantity * item.price
  end
end
