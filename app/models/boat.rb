class Boat < ApplicationRecord
    belongs_to :profile
    has_many :schedules
    has_many :jobs, through: :schedules
    has_one_attached :avatar
    include BoatsHelper
end
