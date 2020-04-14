class FriendsController < ApplicationController

   def index

  end
   

   def search  
    if params[:search].blank?  
      redirect_to( "/", alert: "Empty field!") and return
    else  
      @parameter = params[:search] 
      # @users = User.where(" email LIKE :search", search: @parameter).first(1)
      @user = User.where(" email LIKE :search", search: @parameter).first

      
      userid=1
    if @user
      @friend=Friend.new
      @friend.friend_id=@user.id
      @friend.user_id=userid
      @friend.status="true"
      @friend.save()
    end
    @all_friends=[]
    @user_loged=User.where(id: userid).first
    @friends=@user_loged.friends.order("created_at DESC") 
    p  @friends
    @friends.each do |friend_data|
      friend = User.where("id = ? ", friend_data)
      @all_friends += friend if friend
    end
    @all_friends



      # @all_friends = User.all.joins(:friends)


      

    
    end 
  end
 



end
