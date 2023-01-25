class Cell

    attr_reader :ship, :coordinate

    def initialize(coordinate, owner)
        @coordinate = coordinate
        @ship = nil
        @is_fired_upon = false
        @owner = owner
    end

    def empty?
        @ship == nil
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
        @is_fired_upon
    end

    def fire_upon
        if !empty?
            @ship.hit
        end
        @is_fired_upon = true
        #return value:
        if !empty? && @ship.sunk?
            "hit and sunk #{@owner == :computer ? "my" : "your"} #{@ship.name}"
        elsif !empty? 
            "hit"
        else
            "miss"
        end
    end

    def render(render_hidden_ship = false)
        if fired_upon? && empty?
            "M"
        elsif fired_upon? && @ship.sunk?
            "X"
        elsif hit?
            "H"
        elsif render_hidden_ship && !empty?
            "S"
        else 
            "."
        end
    end

    def hit?
        @is_fired_upon && !empty? && !@ship.sunk?
    end
end