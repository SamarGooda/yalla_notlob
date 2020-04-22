class AuthinticationController < ApplicationController
        
    skip_before_action :authorized

    def index
        if logged_in?
            redirect_to '/home' 
        else
            @user = User.new
            render :layout => false
        end
    end  
    
    def register
        @user = User.create(params.require(:user).permit(:fname, :lname, :email, :password))
        session[:user_id] = @user.id
        redirect_to '/home'
    end  
    
    def login
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           redirect_to '/home'
        else
           redirect_to '/', notice: "Wrong credentials, try again!"
        end
    end   
    
    def logout
        session.delete(:user_id)
        redirect_to '/', notice: "You are loged out!"
    end    
end
