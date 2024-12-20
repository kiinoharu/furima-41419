class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true

  validates :item_name,              presence: true
  validates :item_description,       presence: true
  validates :category_id,            numericality: { other_than: 1, message: "can't be blank" }
  validates :item_condition_id,      numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_burden_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_day_id,        numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'must be between ¥300 and ¥9,999,999' }
  validates :price, numericality: { only_integer: true, message: 'is not a number' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :shipping_fee_burden
  belongs_to :prefecture
  belongs_to :shipping_day
  has_one :order

  def sold_out?
    sold_out
  end

  def mark_as_sold_out!
    update(sold_out: true)
  end
end
