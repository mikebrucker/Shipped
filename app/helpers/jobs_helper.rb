module JobsHelper
    def containers_needed_text
        boat_container_sum = 0
        containers_remaining = 0
        self.boats.each do |boat|
            boat_container_sum += boat.max_containers
        end
        containers_remaining = self.containers - boat_container_sum
        "#{self.name}: #{containers_remaining} Containers Needed"
    end

    def containers_needed
        boat_container_sum = 0
        containers_remaining = 0
        self.boats.each do |boat|
            boat_container_sum += boat.max_containers
        end
        self.containers - boat_container_sum
    end

    def eta
        last = ""
        if self.containers_needed > 0
            "#{containers_needed.to_s} Containers Still Need to be Scheduled"
        else
            self.schedules.each do |schedule|
                last = schedule.finish
                if schedule.finish > last
                    last = schedule.finish
                end
            end
            last.strftime("%B, %d, %Y")
        end
    end
end