class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :prefecture_id, :city, :address, :phone_number).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = 'sk_test_a5e12b77e1f67c83ec145eaf' # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
