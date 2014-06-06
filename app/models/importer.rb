require 'csv'

class Importer
  attr_reader :errors, :row_count, :imported_count, :status
  
  def initialize(data)
    # TODO: handle passing a file reference instead of a string to limit memory usage
    @data = data
    @errors = []
    @row_count = 0
    @imported_count = 0
    @status = :failed
  end
  
  def import
    CSV.parse(@data, col_sep: "\t", headers: true) do |row|
      @row_count += 1
      begin
        import_purchase!(row)
        @imported_count += 1
      rescue => e
        @errors << [e, row]
      end
    end
    @status = :success if @errors.blank?
    @status == :success
  end
  
  protected
  
  def import_purchase!(row)
    purchaser = import_purchaser!(row)
    item = import_item!(row)
    quantity = row['purchase count']
    raise 'Missing purchase count' unless quantity.present?
    Purchase.create!(purchaser: purchaser, item: item, quantity: quantity)
  end
  
  def import_purchaser!(row)
    name = row['purchaser name']
    raise 'Missing purchaser name' unless name.present?
    Purchaser.where(name: name).first_or_create!(name: name)
  end
  
  def import_item!(row)
    merchant = import_merchant!(row)
    description = row['item description']
    raise 'Missing item description' unless description.present?
    price = row['item price']
    raise 'Missing item price' unless price.present?
    # TODO: decide how to handle two purchases for the same item with different prices
    Item.where(merchant_id: merchant.id, description: description).first_or_create!(merchant_id: merchant.id, description: description, price: price)
  end
  
  def import_merchant!(row)
    name = row['merchant name']
    raise 'Missing merchant name' unless name.present?
    address = row['merchant address']
    raise 'Missing merchant address' unless address.present?
    # TODO: Handle merchant address changes
    Merchant.where(name: name).first_or_create!(name: name, address: address)
  end
end