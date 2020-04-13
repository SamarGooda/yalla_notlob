class AuthinticationController < ApplicationController
    skip_before_action :authorized
    def index
        @user = User.new
        render :layout => false
    end  
    
    def register
        @user = User.create(params.require(:user).permit(:fname, :lname, :email, :password))
        session[:user_id] = @user.id
        redirect_to '/home'
    end  
    
    def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
           sessions[:user_id] = @user.id
           redirect_to '/home'
        else
           redirect_to '/'
        end
    end    
end
