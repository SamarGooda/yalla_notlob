class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @orders= Order.where(user_id: current_user.id).last(6).reverse
    @activities= Activity.where(recipient_id: current_user.id).last(6).reverse
   
  end
end
