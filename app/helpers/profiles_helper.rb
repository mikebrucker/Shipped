module ProfilesHelper
    def officer
        "#{self.rank} #{self.fname} #{self.lname}"
    end
end