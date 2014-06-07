require 'rails_helper'

RSpec.describe Purchase, :type => :model do
  it "should require quantity" do
    purchase = build(:purchase, quantity: nil)
    expect(purchase).to have(1).error_on(:quantity)
  end
  
  it "should require purchaser" do
    purchase = build(:purchase, purchaser: nil)
    expect(purchase).to have(1).error_on(:purchaser)
  end
  
  it "should require item" do
    purchase = build(:purchase, item: nil)
    expect(purchase).to have(1).error_on(:item)
  end

  it "should calculate total" do
    item = build(:item, price: 3.0)
    purchase = build(:purchase, quantity: 2, item: item)
    expect(purchase.total).to eq(6.0)
  end
end
