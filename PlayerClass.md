# Player Class
## Requirements
Should have instance variable `@computer` which holds and object of the `Computer` class.

Should have instance variable `@board` that is accessible with `attr_reader`.

@board should be initialized as a new board each round in the `initialize` method.

Should have a method called `place_ships` that gets the user input for where to place the ships per the project specs. ships can be placed on the board using the `@board.place(...)` method

Should have a method called `fire` which gets the user input for which cell they would like to fire on, It then fires at the computer's board using `@computer.board.cells[coordinate].fire_upon` method. Should not fire on cells which are already `fired_upon?`. Should also puts a string to the terminal that says "Your shot on #{coordinate} was a hit/miss"

Should have a method called `all_ships_sunk?` which returns true if all the ships on `@board` are sunk. May be helpful to create an instance variable for the computer that holds an array of the ships on the board so we can easily iterate through them with `@ships.all?{ |ship| ship.sunk? }`. Currently ships are only stored by the individual cells.




