class Player
  attr_accessor :backpack

  def initialize
    @backpack = []
  end

  ## Add to backpack
  def pick_up(item)
    @backpack << item
  end

  # Remove item from backpack
  def remove_item(item)
    @backpack.delete(item)
  end

  # Return true if item is in backpack
  def has_item?(item)
    return true if @backpack.include?(item)
  end

  # Print contents of backpack
  def print_backpack
    if @backpack.empty?
      puts "You aren't carrying anything"
    else
      puts "You are carrying: \n"
      @backpack.each { |item| puts item}
    end
  end

end
