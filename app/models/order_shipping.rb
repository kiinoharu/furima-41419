class OrderShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :phone_number, :token, :item_id, :user_id

  # バリデーション
  validates :postal_code, :prefecture_id, :city, :address, :phone_number, :token, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, numericality: { other_than: 0, message: 'must be selected' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Enter a 10 or 11 digit number.' }

  def save
    # Orderの保存
    order = Order.create(user_id:, item_id:)

    # ShippingDetailの保存
    ShippingDetail.create(
      postal_code:,
      prefecture_id:,
      city:,
      address:,
      phone_number:,
      order_id: order.id
    )
  end
end
