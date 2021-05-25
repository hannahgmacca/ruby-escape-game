# Class for storing item information and attributes
class Item
  def initialize(name, collect_description, use_description, is_key)
    @name = name
    @collect_description = collect_description
    @use_description = use_description
    @is_key = is_key
  end

  # Return item name
  def name
    @name
  end

  # Return item collected description
  def collect_description
    @collect_description
  end 

  # Return item used descriptiom
  def use_description
    @use_description
  end

  # Return true if is key is true
  def is_key?
    @is_key
  end

  # Return true if name matches string given by user
  def is_item?(item_string)
    return true if @name == item_string
  end

end
