class Order < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  has_many :orderItems
end
