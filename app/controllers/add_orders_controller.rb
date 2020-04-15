class AddOrdersController < ApplicationController
  def index
    @order = Order.new
    # redirect_to '/home'
  end

  def add

    @order = Order.create(params.require(:order).permit(:kind, :resturant ,:user ,:status))
    redirect_to '/orders'
    # @order = Order.new
    # @order.type= params[:type]
    # @order.resturant=params[:resturant]
    # # @order.status=params[:status]
    # @order.save
    p "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"
  end

end
