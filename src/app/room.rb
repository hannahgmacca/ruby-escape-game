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

    def hasItems?(item)
        return true if @items.include
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

    def print_exits
        @exits.each { |direction, room| puts "#{direction} leads to #{room}" }
    end

end