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
 



end
