class FriendsController < ApplicationController

   def index
    @all_friends = User.joins("INNER JOIN friends ON friends.friend_id = users.id")
    if @all_friends.blank? 
        @notfound= "You have not any friends yet, enter email of the person you would like to add"
    else
        @all_friends
    end
  end



   def search   
      @useremail= current_user.email
      @parameter = params[:search] 
      if @parameter.blank? 
        @error= "you entered empty email"

      elsif @parameter == @useremail
        @error=  "you can't add yourself"
      else
        @user = User.where(" email LIKE :search", search: @parameter).first
      
        if @user
          @friend = Friend.find_by(friend_id: @user.id)
        else
          @error= 'User not found'
        end
      
        if @friend
          @error = "you are already friends"
        else
          userid= current_user.id
          if @user
            @friend=Friend.new
            @friend.friend_id=@user.id
            @friend.user_id=userid
            @friend.status="true"
            @friend.save()
          end
        end


      end

      if @error.blank?
          @error=  'you are now friends'
      end  

      redirect_to '/friends', notice: @error
  
  
  end


  def destroy
    @id=params[:id]
    p @id
    @friend = Friend.find_by(friend_id: @id)

    @friend.destroy
    redirect_to '/friends', notice: 'Friend deleted successfully.' 
  end







end
