FactoryGirl.define do
  factory :purchase do
    quantity 5
    purchaser
    item
  end
end