class AddOrdersController < ApplicationController
  $list = []

  def index
    @order = Order.new
    @member_list = $list
  end

  def add

    if params[:commit] == 'Add'
      @parameter = params[:search]
      @user = User.where(email: @parameter).first
      if @user
        # for i in $list do
        #   p(i)
        #   p(@parameter)
        #   if i == @parameter
        #     p(i)
        #     p(@parameter)
        #   else
        #     p(i)
        #     p(@parameter)
        #     $list.append(@parameter)
        #   end
        # end
        $list.append(@parameter)
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
       @friend = OrderFriend.new
              @friend.orders_id = @order.id
              @friend.user_id = current_user.id
              @friend.status = "invite"
      @friend.save()
      redirect_to '/orders'
      uploaded_io = params.require(:order)[:menu]
    end
  end

  def order_details
        @order_object = Order.find(params[:id])
        @order_id = @order_object.id
        @all_orders = ActiveRecord::Base.connection.execute("SELECT * FROM order_items WHERE  order_id = #{@order_id}") #i have all items for specified order
        if @all_orders
          @all_orders.each do |order|
            @user_id = order[6]
            @user = User.find(@user_id)
            puts(@user.id)
          end
        end
        # @user = User.find(@all_orders.user_id) #this returns the user who created the order not the user who added items to order
      end
  

  def save_items
    @order_object = Order.find(params[:id])
    @order_id = @order_object.id
    @user = User.find(current_user.id)
    @user_status = OrderFriend.find(params[:id])
    @user_status.status = "joined" 
    @user_status.save


    @order = OrderItem.new
    @order.order_id = @order_id 
    @order.item = params[:item]
    @order.quantity = params[:quantity]
    @order.price = params[:price] 
    @order.comment = params[:comment]
    @order.status = "waiting"
    @order.user_id = current_user.id
    
    valid = validate_items(@order.item, @order.quantity, @order.price, @order.comment)
    if valid == true
        @order.save
        @all_orders = ActiveRecord::Base.connection.execute("SELECT * FROM order_items WHERE  order_id = #{@order_id}")
        
    end
    redirect_to action: :order_details
  end

  def validate_items(order_item, order_quantity, order_price, order_comment)
    valid = true
    if !order_item || !order_quantity || !order_price
        flash.alert = "Order Details(Items, Quantity, Price) are Required"
        valid = false
    else
        flash.alert = "Done"
        valid = true
    end
    return valid
  end


    def list
      @orders = Order.all()
    end


    def search

    end


  end

