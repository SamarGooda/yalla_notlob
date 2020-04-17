class HomeController < ApplicationController
  def index
    @notification = Notification.new
    @notification.recipient_id = current_user.id
    @notification.actor_id = current_user.id
    @notification.action = "posted"
    @notification.save
    puts(current_user.email, @notification.action, @notification.recipient_id)
    puts("nmnmnmdnfmsnfdsfhsgafaduyabdua@4567ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss")    
  end
end
