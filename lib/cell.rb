class Cell

    attr_reader :ship, :coordinate

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def empty?
        @ship == nil
    end

    def place_ship(ship)
        @ship = ship
    end

    def fired_upon?
        @fired_upon
    end

    def fire_upon
        if !empty?
            @ship.hit
            @fired_upon = true
        end
    end

end