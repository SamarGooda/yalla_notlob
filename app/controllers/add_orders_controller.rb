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
    @order.status = "waiting"
    # @order.img=params.require (:order)[menu: uploaded_io.original_filename]
    # @order.menu = params.require(:order)[:menu].original_filename

    @order.save
    redirect_to '/orders'
    uploaded_io = params.require(:order)[:menu]
  #   File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  #     file.write(uploaded_io.read)
  #
  #   # params.require(:order).permit(:order_type, :resturant, :menu)
  #   end
  #   order = Order.create(user_id: current_user.id,resturant: params[:order][:resturant], order_type: params[:order][:order_type], menu: uploaded_io.original_filename, status: "waiting")
  end

  # private
  # def orderParameters
  #   params.require(:order).permit(:order_type, :resturant, :menu)
  # end
  end