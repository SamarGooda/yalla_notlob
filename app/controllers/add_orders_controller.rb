class AddOrdersController < ApplicationController
  def index
    @order = Order.new
  end

  def add

    # @order = Order.create(params.require(:order).permit(:kind, :resturant ,:user ,:status))

    @order = Order.new
    @order.kind= params.require(:order)[:kind]
    @order.resturant= params.require(:order)[:resturant]
    @order.status= params.require(:order)[:status]
    @order.user_id = current_user.id
    @order.img=params.require (:order)[menu: uploaded_io.original_filename]

    @order.save
    redirect_to '/orders'


    # params.require(:order).permit(:order_type, :resturant, :menu)
end
end