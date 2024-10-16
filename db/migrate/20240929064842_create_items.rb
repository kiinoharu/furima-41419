class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string     :item_name,              null: false, default: ""
      t.text       :item_description,       null: false
      t.integer    :category_id,            null: false
      t.integer    :item_condition_id,      null: false
      t.integer    :shipping_fee_burden_id, null: false
      t.integer    :prefecture_id,          null: false
      t.integer    :shipping_day_id,        null: false
      t.integer    :price,                  null: false
      t.references :user,                   null: false, foreign_key: true

      t.boolean :sold_out, default: false
      t.timestamps
    end
  end
end
