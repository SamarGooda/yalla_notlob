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
    @order.image= params.require(:order)[:img]
    @order.user_id = current_user.id
    @order.status = "waiting"
    # @order.img=params.require (:order)[menu: uploaded_io.original_filename]
    # @order.menu = params.require(:order)[:menu].original_filename

    @order.save
    redirect_to '/orders'
    uploaded_io = params.require(:order)[:menu]
  end

  def list
    @orders = Order.all()

  end
  def search
    @parameter = params[:search]
    @user = User.where(" email LIKE :search", search: @parameter).id
    if @user
      @friend=Friend.new
      @friend.friend_id=@user.id
      @friend.user_id=userid
      @friend.status="true"
      @friend.save()
    end

    @all_friends = User.joins("INNER JOIN friends ON friends.friend_id = users.id")
  end

  end