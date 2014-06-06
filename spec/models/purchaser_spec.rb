require 'rails_helper'

RSpec.describe Purchaser, :type => :model do
  it "should require name" do
    purchaser = build(:purchaser, name: "")
    expect(purchaser).to have(1).error_on(:name)
  end
end
