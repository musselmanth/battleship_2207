class Cell

    attr_reader :ship, :coordinate

    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
    end

    def empty?
        @ship == nil
    end

    def place_ship(ship)
        @ship = ship
    end
end