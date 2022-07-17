class Cell

    attr_reader :ship, :coordinate

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @is_fired_upon = false
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
        !empty? #=> method returns true if fire_upon resulted in a hit.
    end

    def render(render_hidden_ship = false)
        if fired_upon? && empty?
            "M"
        elsif fired_upon? && @ship.sunk?
            "X"
        elsif fired_upon? 
            "H"
        elsif render_hidden_ship && !empty?
            "S"
        else 
            "."
        end
    end
end