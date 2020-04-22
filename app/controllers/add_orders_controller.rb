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
              user_id = User.where(email: mail).first.id 
              action = "#{current_user.fname} Invited you to his order."
              type = "invite"
              create_notification(user_id,  current_user.id, action, type, @order.id)
             @activity = Activity.new
             @activity.user_id = current_user.id     #the recipient
             @activity.action = "#{current_user.fname} has created an order from #{@order.resturant} for #{@order.kind}"
             @activity.order_id = @order.id
             @activity.recipient_id = User.where(email: mail).first.id 
             @activity.save    

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
        @joined_friends_num = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM order_friends WHERE status = 'joined' and orders_id = #{@order_id}")
        @invited_friends_num = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM order_friends WHERE status = 'invite' and orders_id = #{@order_id}")
        
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
    # for changing the status for person from invite to joined
    @order_friends = ActiveRecord::Base.connection.execute("SELECT * FROM order_friends WHERE  user_id = #{current_user.id} and orders_id = #{@order_id}") #i have all items for specified order
    if @order_friends
      @order_friends.each do |status|
        ActiveRecord::Base.connection.execute("UPDATE order_friends SET status='joined' WHERE user_id = #{current_user.id} and orders_id=#{@order_id}")
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
    @order_friends = ActiveRecord::Base.connection.execute("SELECT * FROM order_friends WHERE  status = 'joined' and orders_id = #{@order.id}") #i have all items for specified order
    @order_creator = User.find(@order.user_id)
    if @order_friends
      @order_friends.each do |order_friend|
        @user_obj = User.find(order_friend[3])
        @action =  "#{@order_creator.fname} Canceled the order."
        @type = "cancel"
        create_notification(@user_obj.id,  @order_creator.id, @action, @type, @order.id)  
      end
    end


    redirect_to '/orders'
  end


    def finish
      p(params)
      @order = Order.find(params[:id])
      @order.status="finish"
      @order.save()
      @order_creator = User.find(@order.user_id)
      @order_friends = ActiveRecord::Base.connection.execute("SELECT * FROM order_friends WHERE  status = 'joined' and orders_id = #{@order.id}") #i have all items for specified order
      if @order_friends
        @order_friends.each do |order_friend|
          @user_obj = User.find(order_friend[3])
          @type = "finished"
          @action = "#{@order_creator.fname} the order finished."
          create_notification(@user_obj.id, @order_creator.id, @action, @type, @order.id)
      redirect_to '/orders'
        end
      end

      # @order = Order.find(params[:id])
      #
      # @order.destroy()
      # redirect_to '/orders'


    end

  def delete
    p(params)
    for i in $list
       i == params.id
       $list -= [i]
    end
  end

  def create_notification(user_id, actor_id, action, type, order_id)

    @notification = Notification.new
    @notification.user_id = user_id     #the recipient
    @notification.actor_id = actor_id
    @notification.action = action
    @notification.notification_type = type
    @notification.order_id = order_id
    @notification.save  

  end

  def show_joined_friends

    #i have all items for specified order
    @order = Order.find(params[:id])
    @order_id = @order.id
    @order_friends = ActiveRecord::Base.connection.execute("SELECT * FROM order_friends WHERE  status = 'joined' and orders_id = #{@order.id}")
    
    puts("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxzzzzzzzzzzzsssa",@friends_num)
    if @order_friends and @friends_num
      @order_friends.each do |joined_friend|
        @user = User.find(joined_friend[3])
        
      end
    end
    
  end



  def show_invited_friends
    @order = Order.find(params[:id])
    @order_id = @order.id
    @invited_friends = ActiveRecord::Base.connection.execute("SELECT * FROM order_friends WHERE  status = 'invite' and orders_id = #{@order.id}")
  end

  def get_order_id
    @order_id = params[:id]
  end

  def delete_invited_friend 
    
    # @friend = OrderFriend.find(params[:id])
    puts("yabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb")
    puts(params[:id], get_order_id)
    @order_id = get_order_id
    # puts(Params[:name])
    @user = ActiveRecord::Base.connection.execute("DELETE FROM order_friends WHERE status = 'invite' and user_id = #{params[:id]} and orders_id =#{@order_id}")

    redirect_to action: :show_invited_friends
  end


end

