class Trip < ApplicationRecord
    belongs_to :user
    has_many :lists, dependent: :destroy
end
