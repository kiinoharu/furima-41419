FactoryBot.define do
  factory :order_shipping do
    postal_code      { '123-4567' }
    prefecture_id    { 1 }
    city             { 'Tokyo' }
    address          { '1-1-1 Shibuya' }
    building_name    { 'Shibuya Heights' }
    phone_number     { '09012345678' }
    token            { 'tok_abcdefghijk00000000000000000' }

    association :item
    association :user
  end
end
