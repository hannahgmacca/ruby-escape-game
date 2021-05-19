class Player
  attr_accessor :backpack

  def initialize
    @backpack = []
  end

  ## add item to players backpack
  def pickUp(item)
    @backpack << item
  end

  ## remove item from players backpack (whether to use or drop)
  def removeItem(item)
    @backpack.delete(item)
  end

  def hasItem?(item)
    return true if @backpack.include?(item)
  end

end
