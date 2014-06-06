require 'rails_helper'

RSpec.describe Merchant, :type => :model do
  it "should require name" do
    merchant = build(:merchant, name: "")
    expect(merchant).to have(1).error_on(:name)
  end
  
  it "should require address" do
    merchant = build(:merchant, address: "")
    expect(merchant).to have(1).error_on(:address)
  end
end
