class GroupsController < ApplicationController

        def index
            @groups=Group.all
          end
        
    

    
    def  create
        #validatate data
        # store data
        # @post=Post.new
        # @post.title=params[:title]
        # @post.text=params[:text]
        @group=Group.new
        # @group.user_id=1
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
end
