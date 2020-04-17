class AddOrdersController < ApplicationController
  def index
    @order = Order.new
  end

  def add

    # @order = Order.create(params.require(:order).permit(:kind, :resturant ,:user ,:status))

    @order = Order.new
    @order.kind= params[:kind]
    @order.resturant=params[:resturant]
    @order.status=params[:status]
    @order.created_at=DateTime.now
    @order.updated_at=DateTime.now
    @order.user_id = @current_user.id
    p @order.errors
    redirect_to 'orders_path'
    p "result: ", @order.save
    p "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"

end
end