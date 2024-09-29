class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true

  validates :item_name,              presence: true
  validates :item_description,       presence: true
  validates :category_id,            presence: true
  validates :item_condition_id,      presence: true
  validates :shipping_fee_burden_id, presence: true
  validates :prefecture_id,          presence: true
  validates :shipping_day_id,        presence: true
  validates :price,                  presence: true
end
