class Item

    def initialize(name, collect_description, use_description, isKey)
            @name = name
            @collect_description = collect_description
            @use_description = use_description
            @isKey = isKey
    end

    def name_s
        return @name.to_s
    end

end