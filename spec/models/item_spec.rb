require 'rails_helper'

RSpec.describe Item, :type => :model do
  it "should require description" do
    item = build(:item, description: "")
    expect(item).to have(1).error_on(:description)
  end
  
  it "should require price" do
    item = build(:item, price: nil)
    expect(item).to have(1).error_on(:price)
  end
  
  it "should require merchant" do
    item = build(:item, merchant: nil)
    expect(item).to have(1).error_on(:merchant)
  end
end
