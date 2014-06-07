require 'rails_helper'

data_headers = 'purchaser name	item description	item price	purchase count	merchant address	merchant name'
one_row_data = "#{data_headers}
Snake Plissken	$10 off $20 of food	10.0	2	987 Fake St	Bob's Pizza"
four_rows_data = "#{data_headers}
Snake Plissken	$10 off $20 of food	10.0	2	987 Fake St	Bob's Pizza
Amy Pond	$30 of awesome for $10	10.0	5	456 Unreal Rd	Tom's Awesome Shop
Marty McFly	$20 Sneakers for $5	5.0	1	123 Fake St	Sneaker Store Emporium
Snake Plissken	$20 Sneakers for $5	5.0	4	123 Fake St	Sneaker Store Emporium"

RSpec.describe Importer do
  it 'should import a valid row' do
    importer = Importer.new(one_row_data)
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

  it 'should import multiple valid rows' do
    importer = Importer.new(four_rows_data)
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
    expect(item.merchant.name).to eq('Sneaker Store Emporium')
    expect(item.merchant.address).to eq('123 Fake St')
  end

  it 'should require purchaser name' do
    importer = Importer.new("#{data_headers}\n	$10 off $20 of food	10.0	2	987 Fake St	Bob's Pizza")
    status = importer.import
    expect(status).to be(false)
    expect(importer.errors.length).to be(1)
    expect(importer.errors.first[0].to_s).to eq('Missing purchaser name')
  end

  it 'should require item description' do
    importer = Importer.new("#{data_headers}\nSnake Plissken		10.0	2	987 Fake St	Bob's Pizza")
    status = importer.import
    expect(status).to be(false)
    expect(importer.errors.length).to be(1)
    expect(importer.errors.first[0].to_s).to eq('Missing item description')
  end

  it 'should require item price' do
    importer = Importer.new("#{data_headers}\nSnake Plissken	$10 off $20 of food		2	987 Fake St	Bob's Pizza")
    status = importer.import
    expect(status).to be(false)
    expect(importer.errors.length).to be(1)
    expect(importer.errors.first[0].to_s).to eq('Missing item price')
  end

  it 'should require purchase count' do
    importer = Importer.new("#{data_headers}\nSnake Plissken	$10 off $20 of food	10.0		987 Fake St	Bob's Pizza")
    status = importer.import
    expect(status).to be(false)
    expect(importer.errors.length).to be(1)
    expect(importer.errors.first[0].to_s).to eq('Missing purchase count')
  end

  it 'should require merchant address' do
    importer = Importer.new("#{data_headers}\nSnake Plissken	$10 off $20 of food	10.0	2		Bob's Pizza")
    status = importer.import
    expect(status).to be(false)
    expect(importer.errors.length).to be(1)
    expect(importer.errors.first[0].to_s).to eq('Missing merchant address')
  end

  it 'should require merchant name' do
    importer = Importer.new("#{data_headers}\nSnake Plissken	$10 off $20 of food	10.0	2	987 Fake St	")
    status = importer.import
    expect(status).to be(false)
    expect(importer.errors.length).to be(1)
    expect(importer.errors.first[0].to_s).to eq('Missing merchant name')
  end

  it 'should report import status' do
    importer = Importer.new(one_row_data)
    importer.import
    expect(importer.status).to eq(:success)
  end
end