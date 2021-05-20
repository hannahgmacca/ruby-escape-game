require_relative 'item'

class ScoreItem < Item
    attr_accessor :score
    
    def initialize(name, collect_description, use_description, isKey, score)
      super(name, collect_description, use_description, isKey)
      @score = score
    end

    def score
      @score
    end
    
end