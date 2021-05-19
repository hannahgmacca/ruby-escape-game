class Room
    def initialize(name, description, isLocked, items, exits)
    @name = name
    @description = description
    @isLocked = isLocked
    @items = items
    @exits = exits
    end

    def setExits(direction, room)
        @exits << direction => room
    end

    def room_name
        @name.to_s
    end

    ## if room has this exit then return the room it leads to
    def hasExit?(command)
      @exits.each do |direction, room|
        if direction == command.to_sym
            return room
        else  
            return false
        end
      end
    end

    ## if room has this item then return item
    def hasItem?(command)
      return true if @items.include?(command)
    end

    def removeItem(item)
      @items.delete(item)
    end

    def print_exits
      @exits.each { |direction| print "#{direction}" }
      puts "\n"
    end

    def print_name
      @name
    end

    def print_items
      @items.each { |item| print "#{item}" }
      puts "\n"
    end

end