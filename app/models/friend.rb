class Friend < ApplicationRecord
    belongs_to :user
    has_many :groupfriends
    has_many :groups, through: :groupfriends


end
