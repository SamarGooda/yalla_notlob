class Group < ApplicationRecord
  has_many :groupfriends
  has_many :friends, through: :groupfriends


end
