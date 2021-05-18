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

    def hasItems(item)
        return true if @items.include
    end

    # ## for a given command, return the matching object
    # def getRoomItem(command)
    #     @items.each |item|
    #       if command == item.name
    #         @items - item
    #       else
    #         puts "This item isn't here to take"
    #       end
    # end

    ## if room has this exit then return the room it leads to
    def getExit(command)
      @exits.each do |direction, room|
        if direction == command
            return room
        else  
            return false
        end
      end
    end

    # def hasExit(command)
    #     if 
    # end








end