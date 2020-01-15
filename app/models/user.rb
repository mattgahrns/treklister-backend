class User < ApplicationRecord
    has_secure_password
    has_many :trips, dependent: :destroy
    validates :username, uniqueness: true
end
