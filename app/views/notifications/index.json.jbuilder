json.array! @notifications do |notification|
    json.user_id notification.user_id
    json.actor_id notification.actor_id
    json.action notification.action
    json.order_id notification.order_id
    json.read_at notification.read_at
end
