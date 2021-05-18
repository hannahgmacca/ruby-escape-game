class Player
    attr_accessor :backpack

    def initialize
        @backpack = []
    end

    def pickUp(item)
        backpack << item
    end

    def drop(item)
        backpack.delete(item)
    end

end
