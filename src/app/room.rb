require 'colorize'

# Class for storing and accessing room information
class Room
    def initialize(name, items, exits)
    @name = name
    @items = items
    @exits = exits
    end

    # Returns true is room has this exit
    def has_exit?(direction)
      return true if @exits.has_key?(direction.to_sym)
    end

    # Returns exit this direction leads to
    def get_exit(command)
      @exits.each do |direction, room|
        if direction.to_s == command
          return room
        end
      end
    end

    # Returns true is room has item
    def has_item?(command)
      return true if @items.include?(command)
    end

    # Removes item from room
    def remove_item(item)
      @items.delete(item)
    end

    # Prints room exits
    def print_exits
      @exits.each { |direction, exit| print "#{direction} " }
      puts "\n"
    end

    # Return room name
    def print_name
      @name
    end

    # Print items found in room
    def print_items
      @items.each { |item| print "#{item} "}
      puts "\n"
    end

    # Return true if room has this name
    def is_room?(room_string)
      return true if @name == room_string
    end

    # Returns room has any items
    def has_items?
      return true if @items.empty? == false
    end
end