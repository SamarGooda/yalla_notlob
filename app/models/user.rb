class User < ApplicationRecord
    #encrypt password
    has_secure_password
    has_many :notifications
end
