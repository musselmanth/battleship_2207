# Computer Class
## Requirements
Should have instance variable `@player` which holds and object of the `Player` class.

`@player` needs to be accessible for  writing. => `attr_writer`

Should have instance variable `@board` that is accessible with `attr_reader`.

@board should be initialized as a new board each round in the `initialize` method.

Should have a method called `place_ships` that randomly chooses where the computers ships will go and places them on the @board object using the `@board.place(...)` method

Should have a method called `fire` which randomly (or smartly for Iteration 4) fires at a player's board using `@player.board.cells[coordinate].fire_upon` method. Should not fire on cells which are already `fired_upon?`. Should also puts a string to the terminal that says "My shot on #{coordinate} was a hit/miss"

Should have a method called `all_ships_sunk?` which returns true if all the ships on `@board` are sunk. May be helpful to create an instance variable for the computer that holds an array of the ships on the board so we can easily iterate through them with `@ships.all?{ |ship| ship.sunk? }`. Currently ships are only stored by the individual cells.




