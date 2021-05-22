class Item
  def initialize(name, collect_description, use_description, isKey)
    @name = name
    @collect_description = collect_description
    @use_description = use_description
    @isKey = isKey
  end

  def name
    @name
  end

  def collect_description
    @collect_description
  end 

  def use_description
    @use_description
  end

  def is_key?
    @isKey
  end

  ## for items that require another item to be used first
  def give_prerequisite(item)
    @prerequisite = item
  end

  def is_item?(item_string)
    return true if @name == item_string
  end

end
