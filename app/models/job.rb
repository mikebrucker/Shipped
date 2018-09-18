class Job < ApplicationRecord
    has_many :schedules
    has_many :boats, through: :schedules
end
