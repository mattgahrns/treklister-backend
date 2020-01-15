class List < ApplicationRecord
    belongs_to :trip
    has_many :list_items, dependent: :destroy
end
