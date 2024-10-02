FactoryBot.define do
  factory :item do
    association :user
    item_name              { 'サンプル商品' }
    item_description       { 'これはサンプルの商品説明です。' }
    category_id            { 2 }
    item_condition_id      { 2 }
    shipping_fee_burden_id { 2 }
    prefecture_id          { 2 }
    shipping_day_id        { 2 }
    price                  { 1000 }

    # 画像をアタッチ
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'images', 'files', 'sample_image.png')),
                        filename: 'sample_image.png', content_type: 'image/png')
    end
  end
end
