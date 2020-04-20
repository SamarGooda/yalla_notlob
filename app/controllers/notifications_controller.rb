class  NotificationsController < ApplicationController
    # caches_page :mark_as_reads
    
    # before_action :authenticate_user!
    def index
        # @notifications = Notification.where(user: current_user).unread
        @notifications = Notification.where(user: current_user)
    end
    # "user" is the recipient of the notification
    skip_before_action :verify_authenticity_token
    def mark_as_reads
        @notifications = Notification.where(user: current_user).unread
        @notifications.update_all(read_at: Time.zone.now)
        render json: {success: true}
    end
    
end