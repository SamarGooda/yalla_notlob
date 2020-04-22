class FriendsController < ApplicationController

   def index
    @all_friends = User.joins("INNER JOIN friends ON friends.friend_id = users.id")

  end

  # def  show
  # end
   

   def search   
      @parameter = params[:search] 
      @user = User.where(" email LIKE :search", search: @parameter).first
      userid=1
    if @user
      @friend=Friend.new
      @friend.friend_id=@user.id
      @friend.user_id=userid
      @friend.status="true"
      @friend.save()
    end

    @all_friends = User.joins("INNER JOIN friends ON friends.friend_id = users.id")

  end
 


  def list_activities
    @my_friends = ActiveRecord::Base.connection.execute("SELECT * FROM friends WHERE  user_id = #{current_user.id}")
    if @my_friends
      @my_friends.each do |friend|
        p("friend is ", friend[5])
        @each_friend_detail = ActiveRecord::Base.connection.execute("SELECT * FROM users WHERE  id = #{friend[5]} ")
        @each_friend_order = ActiveRecord::Base.connection.execute("SELECT * FROM orders WHERE  user_id = #{friend[5]}")

    end
  end
end


end
