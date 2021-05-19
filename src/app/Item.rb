class Item
  def initialize(name, collect_description, use_description, isKey)
    @name = name
    @collect_description = collect_description
    @use_description = use_description
    @isKey = isKey
  end

  def print_name
    @name.to_s
  end

  def print_collected
    @collect_description.to_s
  end 

  def print_used
    @use_description.to_s
  end

  def is_key?
    @isKey
  end

  ## for items that require another item to be used first
  def give_prerequisite(item)
    @prerequisite = item
  end

  def isItem?(item_string)
    return true if @name == item_string
  end

end