class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = Order.all
  end

  def create
  end
end
