class ShippingDetail < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, presence: true, numericality: { other_than: 0, message: 'must be selected' }
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true,
                           format: { with: /\A\d{10,11}\z/, message: 'is invalid. Enter a 10 or 11 digit number.' }
end
