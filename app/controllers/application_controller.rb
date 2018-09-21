class ApplicationController < ActionController::Base
    def location_list
        ['Philadelphia', 'Miami', 'Copenhagen', 'San Diego', 'Portland', 'New York City', 'Lisbon', 'Cuba', 'Hawaii', 'Puerto Rico']
    end
    def rank_list
        ['Seaman Apprentice', 'Seaman', 'Petty Officer Third Class', 'Petty Officer Second Class', 'Petty Officer First Class', 'Chief Petty Officer', 'Senior Chief Petty Officer', 'Master Chief Petty Officer', 'Command Master Chief Petty Officer', 'Master Chief Petty Officer of the Navy', 'Ensign', 'Lieutenant Junior Grade', 'Lieutenant', 'Lieutenant Commander', 'Commander', 'Captain', 'Rear Admiral Lower Half', 'Rear Admiral', 'Vice Admiral', 'Admiral', 'Fleet Admiral']
    end
    
    helper_method :rank_list
    helper_method :location_list
end
