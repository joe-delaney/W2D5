require_relative 'list.rb'
require_relative 'item.rb'

class ToDoBoard

    def initialize
        @lists = {}
    end

    def get_command
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd 
        when 'mktodo'
            if (args.length == 3 || args.length == 4) && valid_list?(args[0])
                list_label = args[0]
                title = args[1]
                deadline = args[2]
                description = args[3] if args.length == 4
                description ||= ""
                @lists[list_label].add_item(title, deadline, description)
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'mklist'
            if args.length == 1
                list_name = args[0]
                @lists[list_name] = List.new(list_name)
            else
                p "invalid number of arguments"
            end
        when 'ls'
            print_lists
        when 'showall'
            showall
        when 'up'
            if (args.length == 2 || args.length == 3) && valid_list?(args[0])
                list_label = args[0]
                index = args[1].to_i
                amount = args[2].to_i if args.length == 3
                amount ||= 1
                @lists[list_label].up(index, amount)
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'down'
            if (args.length == 2 || args.length == 3) && valid_list?(args[0])
                list_label = args[0]
                index = args[1].to_i
                amount = args[2].to_i if args.length == 3
                amount ||= 1
                @lists[list_label].down(index, amount)
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'swap'
            if args.length == 3 && valid_list?(args[0])
                list_label = args[0]
                idx1 = args[1].to_i
                idx2 = args[2].to_i
                @lists[list_label].swap(idx1, idx2)
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'sort' 
            if args.length == 1 && valid_list?(args[0])
                list_label = args[0]
                @lists[list_label].sort_by_date!
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'priority'
            if args.length == 1 && valid_list?(args[0])
                list_label = args[0]
                @lists[list_label].print_priority
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'print'
            if args.length == 1 && valid_list?(args[0])
                list_label = args[0]
                @lists[list_label].print
            elsif args.length == 2 && valid_list?(args[0])
                list_label = args[0]
                idx = args[1].to_i
                @lists[list_label].print_full_item(idx)
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'toggle'
            if args.length == 2 && valid_list?(args[0])
                list_label = args[0]
                idx = args[1].to_i
                @lists[list_label].toggle_item(idx)
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'rm'
            if args.length == 2 && valid_list?(args[0])
                list_label = args[0]
                idx = args[1].to_i
                @lists[list_label].remove_item(idx)
            else
                p "invalid number of arguments or invalid list label"
            end
        when 'purge'
            if args.length == 1 && valid_list?(args[0])
                list_label = args[0]
                @lists[list_label].purge
            else
                p "invalid number of arguments or invalid list label"
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

    def print_lists
        p '--------------------------------------'
        p "TO DO LISTS: "
        @lists.keys.each_with_index do |list_name, idx| 
            print "List #" + idx.to_s + ": "
            puts list_name
        end
        p '--------------------------------------'
    end

    def showall
        i = 0
        @lists.each do |list_label, list|
            p 'List at Index: '+ i.to_s
            list.print
            i+=1
        end
    end

    def valid_list?(list_label)
        @lists.has_key?(list_label)
    end
end

board = ToDoBoard.new
board.run