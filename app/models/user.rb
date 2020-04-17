class User < ApplicationRecord
    #encrypt password
    has_secure_password

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    #
    # validates :email, presence: true
    # # validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: true }
    # validates :password, presence: true, length: { minimum: 6 }
    # validates_confirmation_of :password
    # validates_presence_of :password_confirmation
    # validates :fname, presence: true
    # validates :lname, presence: true

end
