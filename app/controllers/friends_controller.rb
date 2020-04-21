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
    @useremail="sabreen@gmail.com"
    @parameter = params[:search] 
    if @parameter.blank? 
      @emptyemail = "you entered empty email"

    elsif @parameter == @useremail
       @addyourself =  "you can't add yourself"
    else
      @user = User.where(" email LIKE :search", search: @parameter).first
     
      if @user
         @friend = Friend.find_by(friend_id: @user.id)

      end
     
      if @friend
        @repeatuser = "you are already friends"
      else
        userid=1
        if @user
          @friend=Friend.new
          @friend.friend_id=@user.id
          @friend.user_id=userid
          @friend.status="true"
          @friend.save()
        end
      end


    end


  
  
  end


  def destroy
    @id=params[:id]
    p @id
    @friend = Friend.find_by(friend_id: @id)

    @friend.destroy

  end







end
