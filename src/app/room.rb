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


end