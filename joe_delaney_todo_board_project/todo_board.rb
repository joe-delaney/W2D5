require_relative 'list.rb'
require_relative 'item.rb'

class ToDoBoard

    def initialize(label)
        @list = List.new(label)
    end

    def get_command
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd 
        when 'mktodo'
            if args.length == 2 || args.length == 3
                title = args[0]
                deadline = args[1]
                description = args[2] if args.length == 3
                description ||= ""
                @list.add_item(title, deadline, description)
            else
                p "invalid number of arguments"
            end
        when 'up'
            if args.length == 1 || args.length == 2
                index = args[0].to_i
                amount = args[1].to_i if args.length == 2
                amount ||= 1
                @list.up(index, amount)
            else
                p "invalid number of arguments"
            end
        when 'down'
            if args.length == 1 || args.length == 2
                index = args[0].to_i
                amount = args[1].to_i if args.length == 2
                amount ||= 1
                @list.down(index, amount)
            else
                p "invalid number of arguments"
            end
        when 'swap'
            if args.length == 2
                idx1 = args[0].to_i
                idx2 = args[1].to_i
                @list.swap(idx1, idx2)
            else
                p "invalid number of arguments"
            end
        when 'sort'
            @list.sort_by_date!
        when 'priority'
            @list.print_priority
        when 'print'
            if args.length == 0
                @list.print
            elsif args.length == 1
                idx = args[0].to_i
                @list.print_full_item(idx)
            else
                p "invalid number of arguments"
            end
        when 'quit'
            return false 
        else
            p "Sorry, that command is not recognized"
        end
        return true
    end

    def run 
        flag = true
        while flag
            flag = false if !get_command
        end
    end
end