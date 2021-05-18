class Room
    def initalize(name, description, isLocked)
    @name = name
    @description = description
    @isLocked = isLocked
    @items = []
    @exits = {}
    end

    def setExits(direction, room)
        @exits << :direction => room
    end


end