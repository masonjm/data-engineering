require 'rails_helper'

RSpec.describe Importer do
  it "should import a valid row" do
    data = "purchaser name	item description	item price	purchase count	merchant address	merchant name
Snake Plissken	$10 off $20 of food	10.0	2	987 Fake St	Bob's Pizza"
    importer = Importer.new(data)
    status = importer.import
    expect(status).to be_truthy
    expect(importer.row_count).to be(1)
    expect(importer.imported_count).to be(1)
    expect(Purchaser.where(name: 'Snake Plissken').count).to be(1)
    item = Item.where(description: '$10 off $20 of food').first
    expect(item).to be_an(Item)
    expect(item.purchases.count).to be(1)
    expect(item.merchant.name).to eq("Bob's Pizza")
  end
  
  it "should import valid data" do
    data = "purchaser name	item description	item price	purchase count	merchant address	merchant name
Snake Plissken	$10 off $20 of food	10.0	2	987 Fake St	Bob's Pizza
Amy Pond	$30 of awesome for $10	10.0	5	456 Unreal Rd	Tom's Awesome Shop
Marty McFly	$20 Sneakers for $5	5.0	1	123 Fake St	Sneaker Store Emporium
Snake Plissken	$20 Sneakers for $5	5.0	4	123 Fake St	Sneaker Store Emporium"
    importer = Importer.new(data)
    status = importer.import
    expect(status).to be_truthy
    expect(importer.row_count).to be(4)
    expect(importer.imported_count).to be(4)
    expect(Purchaser.where(name: 'Snake Plissken').count).to be(1)
    item = Item.where(description: '$20 Sneakers for $5').first
    expect(item).to be_an(Item)
    expect(item.price).to eq(5.0)
    expect(item.purchases.count).to be(2)
    expect(item.purchases.last.quantity).to eq(4)
    expect(item.merchant.name).to eq("Sneaker Store Emporium")
    expect(item.merchant.address).to eq("123 Fake St")
  end
end