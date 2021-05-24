class Room
    def initialize(name, description, isLocked, items, exits)
    @name = name
    @description = description
    @isLocked = isLocked
    @items = items
    @exits = exits
    end

    def room_name
        @name.to_s
    end

    ## if room has this exit then return the room it leads to
    def has_exit?(direction)
      return true if @exits.has_key?(direction.to_sym)
    end

    def get_exit(command)
      @exits.each do |direction, room|
        if direction.to_s == command
          return room
        end
      end
    end

    ## if room has this item then return item
    def has_item?(command)
      return true if @items.include?(command)
    end

    def remove_item(item)
      @items.delete(item)
    end

    def print_exits
      @exits.each { |direction, exit| print "#{direction} " }
      puts "\n"
    end

    def print_name
      @name
    end

    def print_items
      @items.each { |item| print "#{item} " }
      puts "\n"
    end

    def is_room?(room_string)
      return true if @name == room_string
    end

    def has_items?
      return true if @items.empty? == false
    end
end