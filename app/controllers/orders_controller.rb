class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping = OrderShipping.new # 正しいクラス名を使用
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      pay_item
      @order_shipping.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      token: params[:token], item_id: params[:item_id], user_id: current_user.id
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAY.JPの秘密鍵
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 日本円
    )
  end
end
