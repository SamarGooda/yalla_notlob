class GroupsController < ApplicationController

      def index
            @groups=Group.all
            if @groups.blank? 
              @notfound= "you don't create any group yet"
            else
              @groups
            end
      end
        
    

    
    def  create
        @group=Group.new
        @group.name=params[:name]
        @group.user_id = 1

        @group.save()
        redirect_to action:  :index
      end


      def update
        @all = User.joins("INNER JOIN friends ON friends.friend_id = users.id")
        if @all.blank? 
            @notfound= "You have not any friends yet, enter email of the person you would like to add"
        else
           p @all
        end
        @parameter = params[:search] 
        @user = User.where("email LIKE :search", search: @parameter)
        @friend = Friend.where(friend_id: @user.ids ).where(user_id: 1)
        p @friend.ids[0]
         if @friend.blank? 
          @notfriend = "your are not friends"

         else
          @group =Groupfriend.new
          @group.friend_id =@friend.ids[0]
          @groupid=params[:id]
          @group.group_id = @groupid
          @group.save()
         end


      end

      def  destroy
        @groupid=params[:id]
        @group=Groupfriend.where(group_id: @groupid)
        @deleteGroup = Group.find(@groupid)
        @group.destroy_all
        @deleteGroup.destroy
      end
end
