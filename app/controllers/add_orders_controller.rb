class AddOrdersController < ApplicationController
  $list=[]

  def index
    @order = Order.new
    @member_list = $list
  end

  def add
    # @order = Order.new
    # p($list)
    # $list.append(params[:search])
    # p($list)
    # render :index

    if params[:commit] == 'Add'
      @parameter = params[:search]
      @user = User.where( email: @parameter ).first
      if @user
        if not @parameter in $list
           $list.append(@parameter)
        end
        @order = Order.new
        @order.kind = params.require(:order)[:kind]
        @order.resturant = params.require(:order)[:resturant]
        @order.status = params.require(:order)[:status]
        @order.image = params.require(:order)[:img]
        @member_list = $list
        render :index
      else
        @order = Order.new
        @order.kind = params.require(:order)[:kind]
        @order.resturant = params.require(:order)[:resturant]
        @order.status = params.require(:order)[:status]
        @order.image = params.require(:order)[:img]
        @member_list = $list
        render :index
      end

    elsif params[:commit] == 'Publish'
        @order = Order.new
        @order.kind = params.require(:order)[:kind]
        @order.resturant = params.require(:order)[:resturant]
        @order.status = params.require(:order)[:status]
        @order.image = params.require(:order)[:img]

        @order.user_id = current_user.id
        @order.status = "waiting"
        # @order.img=params.require (:order)[menu: uploaded_io.original_filename]
        # @order.menu = params.require(:order)[:menu].original_filename

        @order.save
        #loop list f friends
        #  @friend = OrderFriend.new
        #         @friend.user_id = @user.id
        #         # @friend.user_id = current_user.id
        #         @friend.status = "invite"
        @friend.save()
        redirect_to '/orders'
        uploaded_io = params.require(:order)[:menu]
  end
    end
  def list
    @orders = Order.all()
  end


  def search

  end
end

