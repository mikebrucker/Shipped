class ApplicationController < ActionController::Base
    def list
        ['Philadelphia', 'Miami', 'Copenhagen', 'San Diego', 'Portland', 'New York City', 'Lisbon', 'Cuba', 'Hawaii', 'Puerto Rico']
    end
    def officer(profile)
        "#{profile.rank} #{profile.fname} #{profile.lname}"
    end
    helper_method :officer
end
