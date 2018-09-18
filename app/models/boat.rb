class Boat < ApplicationRecord
    belongs_to :profile
    has_many :schedules
    has_many :jobs, through: :schedules
end
