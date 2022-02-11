require_relative 'item.rb'

class List

    # print styles
    LINE_WIDTH = 50
    INDEX_COL_WIDTH = 5
    ITEM_COL_WIDTH = 20
    DEADLINE_COL_WIDTH = 10
    DONE_COL_WIDTH = 5


    attr_reader :label

    def initialize(label)
        @label = label
        @items = []
    end

    def label=(new_label)
        @label = new_label
    end

    def add_item(title, deadline, description="")
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            return true
        else
            return false 
        end
    end

    def size
        @items.length
    end

    def valid_index?(index)
        return false if index < 0 || index >= @items.length
        return true
    end

    def swap(index_1, index_2)
        if !valid_index?(index_1) || !valid_index?(index_2)
            return false
        else
            @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
            return true
        end
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def priority
        @items[0]
    end

    def print
        puts "-" * LINE_WIDTH
        puts " " * 16 + self.label.upcase
        puts "-" * LINE_WIDTH
        puts "#{'Index'.ljust(INDEX_COL_WIDTH)} | #{'Item'.ljust(ITEM_COL_WIDTH)} | #{'Deadline'.ljust(DEADLINE_COL_WIDTH)} | #{'Done'.ljust(DONE_COL_WIDTH)}"
        puts "-" * LINE_WIDTH
        @items.each_with_index do |item, i|
            done_txt = '[✓]' if item.done?
            done_txt = '[ ]' if !item.done?
            puts "#{i.to_s.ljust(INDEX_COL_WIDTH)} | #{item.title.ljust(ITEM_COL_WIDTH)} | #{item.deadline.ljust(DEADLINE_COL_WIDTH)} | #{done_txt.ljust(DONE_COL_WIDTH)}"
        end
        puts "-" * LINE_WIDTH
    end

    def print_full_item(index)
        if valid_index?(index)
            item = @items[index]
            done_txt = '[✓]' if item.done?
            done_txt = '[ ]' if !item.done?
            puts "-" * LINE_WIDTH
            puts "#{item.title.ljust(LINE_WIDTH/3)}#{item.deadline.rjust(LINE_WIDTH/3)}#{done_txt.rjust(LINE_WIDTH/3)}"
            puts item.description
            puts "-" * LINE_WIDTH
        end
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount=1)
        if valid_index?(index)
            while amount > 0 && index > 0
                swap(index, index - 1)
                amount -= 1
                index -= 1
            end
            return true
        else
            return false 
        end
    end

    def down(index, amount=1)
        if valid_index?(index)
            while amount > 0 && index < @items.length - 1
                swap(index, index + 1)
                amount -= 1
                index += 1
            end
            return true
        else
            return false 
        end
    end

    def sort_by_date!
        @items.sort_by! { |item| item.deadline}
    end

    def toggle_item(index)
        if valid_index?(index)
            @items[index].toggle
            return true
        else
            return false
        end
    end

    def remove_item(index)
        if valid_index?(index)
            @items.delete_at(index)
        else
            return false 
        end
    end

    def purge
        complete = false
        while !complete
            complete = true
            i = 0
            while complete && i < @items.length
                if @items[i].done?
                    remove_item(i)
                    complete = false
                end
                i += 1
            end
        end
    end
end