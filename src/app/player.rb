class Player
  attr_accessor :backpack

  def initialize
    @backpack = []
  end

  ## add item to players backpack
  def pick_up(item)
    @backpack << item
    puts @backpack.to_s
  end

  ## remove item from players backpack (whether to use or drop)
  def remove_item(item)
    @backpack.delete(item)
  end

  def has_item?(item)
    return true if @backpack.include?(item)
  end

end
