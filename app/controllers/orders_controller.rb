class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_owned_or_sold_out, only: [:index]
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping = OrderShipping.new
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

  def redirect_if_owned_or_sold_out
    return unless @item.user_id == current_user.id || @item.sold_out? # 自身が出品した商品または売却済み商品の場合

    redirect_to root_path
  end
end
