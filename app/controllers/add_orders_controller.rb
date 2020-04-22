class AddOrdersController < ApplicationController
  $list = []
  # $order = Order.new
  def index
    # @order =$order
    @order=Order.new
    @member_list = $list
  end

  def add

    if params[:commit] == 'Add'
      @parameter = params[:search]
      @user = User.where(email: @parameter).first
      # p(@parameter)
      if @user
          @invited_code = @user.id
          @friend =Friend.where(friend_id: @invited_code).where(user_id: current_user)
          p(@friend)
          if @friend

            if not $list.include? @parameter
              $list.append(@parameter)
            end
          end
        p($list)
        # $list.append(@parameter)
        # @order =$order
        @order=Order.new
        @order.kind = params.require(:order)[:kind]
        @order.resturant = params.require(:order)[:resturant]
        @order.status = params.require(:order)[:status]
        @order.image = params.require(:order)[:img]
        @member_list = $list
        # redirect_to '/orders/add'
        render :index
      else
        # @order =$order
        @order=Order.new
        @order.kind = params.require(:order)[:kind]
        @order.resturant = params.require(:order)[:resturant]
        @order.status = params.require(:order)[:status]
        @order.image = params.require(:order)[:img]
        @member_list = $list
        # redirect_to '/orders/add'
        render :index
      end

    elsif params[:commit] == 'Publish'
      # @order =$order
      @order=Order.new
      @order.kind = params.require(:order)[:kind]
      @order.resturant = params.require(:order)[:resturant]
      @order.status = params.require(:order)[:status]
      @order.image = params.require(:order)[:img]

      @order.user_id = current_user.id
      @order.status = "waiting"
      @order.save
      #loop list f friends
      $list.each { |mail|
             @friend = OrderFriend.new
              @friend.orders_id = @order.id
              @friend.user_id =  User.where(email: mail).first.id
              @friend.status = "invite"
             @friend.save()
      }
      $list=[]
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
      end
  

  def save_items
    @order_object = Order.find(params[:id])
    @order_id = @order_object.id
    @user = User.find(current_user.id)
    @order_friends = ActiveRecord::Base.connection.execute("SELECT * FROM order_friends WHERE  user_id = #{current_user.id} and orders_id = #{@order_id}") #i have all items for specified order
    if @order_friends
      @order_friends.each do |status|
        puts("statttttttttttttussssssaaaaaaasss")
        puts(status)
      end
    end    


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


  def cancel
    p(params)
    @order = Order.find(params[:id])
    @order.status="cancel"
    @order.save()
    redirect_to '/orders'
  end


    def finish
      p(params)
      @order = Order.find(params[:id])
      @order.status="finish"
      @order.save()
      redirect_to '/orders'
      # @order = Order.find(params[:id])
      #
      # @order.destroy()
      # redirect_to '/orders'


    end

  def delete
    p("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
    p(params)
    for i in $list
       i == params.id
       $list -= [i]
    end
  end

  end

