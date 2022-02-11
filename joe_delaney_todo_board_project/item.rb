class Item

    attr_reader :title, :description, :deadline

    def self.valid_date?(date_string)
        return false if date_string[4] != '-' || date_string[7] != '-'
        year = date_string[0..3].to_i
        month = date_string[5..6].to_i
        day = date_string[8..9].to_i

        return false if month < 1 || month > 12
        return false if day < 1 || day > 31
        return true
    end

    def initialize(title, deadline, description)
        raise 'deadline is not a valid date' if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def title=(new_title)
        @title = new_title
    end

    def deadline=(new_deadline)
        raise 'new deadline is not a valid date' if !Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end

    def description=(new_description)
        @description = new_description
    end

    def toggle
        @done = !@done
    end

    def done?
        @done 
    end
end