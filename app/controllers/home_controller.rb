class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @orders= Order.last(6).reverse
    # @notification = Notification.new
    # @notification.user_id = current_user.id   #the recipient#
    # @notification.actor_id = current_user.id
    # @notification.action = "#{current_user.fname} yalla naaaaaaaaaaaaaaaaaaaw"
    # @notification.save  
    # puts(current_user.email, @notification.action) 
   
  end
end
