FactoryGirl.define do
  factory :item do
    description '$1 of stuff for $1'
    price 1.0
    merchant
  end
end