class GroupsController < ApplicationController

        def index
            @groups=Group.all
          end
        
    

    
    def  create
        @group=Group.new
        @group.name=params[:name]
        @group.save()
        redirect_to action:  :index
      end


      def update
        @all_friends = User.joins("INNER JOIN friends ON friends.friend_id = users.id")

        @parameter = params[:search] 
        @user = User.where("email LIKE :search", search: @parameter)
        # p @user.ids
        @friend = Friend.where(friend_id: @user.ids ).where(user_id: 1)

        p "iiiiiiiiiiiii"

        p @friend.ids[0]
        p "iiiiiiiiiiiiiiiiiiiiii"

        @group =Groupfriend.new
        @group.friend_id =@friend.ids[0]
        @groupid=params[:id]
        @group.group_id = @groupid
        # p @group.group_id

        @group.save()
      end

      def  destroy
        @groupid=params[:id]
        @group=Groupfriend.where(group_id: @groupid)
        @deleteGroup = Group.find(@groupid)
        @group.destroy_all
        @deleteGroup.destroy
        redirect_to action:  :index
      end
end
