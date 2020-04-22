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
      # p("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
      # p(@parameter)
      if @user
        if not $list.include? @parameter
          $list.append(@parameter)
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

