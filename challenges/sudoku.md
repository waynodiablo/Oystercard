# Sudoku

Before you do this you should have successfully finished the [boris bikes](https://github.com/makersacademy/course/blob/master/boris_bikes.md) and ( _optionally_ ) the [battle ships](https://github.com/makersacademy/course/blob/master/battle_ships.md) projects.

We are going to build a sudoku solver.

## Rules of this challenge

- Pair for most of the time
- Write tests
- You are done when your tests pass, including solving the puzzle
- Write the code to solve an easy sudoku

## Sudoku Rules

If you never played Sudoku, the good news is that the rules are simple. You start with a 9 by 9 grid divided in 9 boxes.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_9qoMG0O1WE1_p.52567_1378724234570_Screen%20Shot%202013-09-09%20at%2011.56.44.png)

The goal of the game is to fill out the entire grid with numbers. The trick is that every row, every column and every box must have all nine digits 1 to 9. That is, if row 1 in this example already has digits 8 and 9, they can't be used in the same row anymore. You can practice playing it at [sudoku9x9.com](http://www.sudoku9x9.com/?level=1).

## How to solve an easy sudoku

To complete the game, you analyse all possible combinations to find out what digit should go into every cell. Let's try to complete the puzzle shown above. It is an easy sudoku because it is pre-filled with a large number of digits, making it easy to guess the missing ones.

Let's start with the first box in the upper left corner. It already has 5 out of 9 cells filled out, so we know that the remaining cells contain

````ruby
(1..9).to_a - [8, 3, 6, 4, 5] #=> [1, 2, 7, 9]
````

Let's start with the first blank cell in the upper left corner. We just found out that it contains 1, 2, 7 or 9. However, the first row that the first cell belongs to contains 8 and 9, so the list of possible values becomes

````ruby
[1,2,7,9] - [8,9] #=> [1, 2, 7]
````

Now let's take a look a the first column and reject all values that are there as possible options.

````ruby
[1, 2, 7] - [8, 4, 7, 3, 1] #=> [2]
````

So, we just found out that the first cell contains 2, the only option that's left. Let's put it in there.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_9qoMG0O1WE1_p.52567_1378725165646_Screen%20Shot%202013-09-09%20at%2012.12.29.png)

Now, the possible options for the second cell are

````ruby
(1..9).to_a - [2, 8, 3, 6, 4, 5] #=> [1, 7, 9]
````

Let's subtract the existing values for the box, row and the column from the list of possible values.

````ruby
(1..9).to_a - [2, 8, 3, 6, 4, 5] - [8,9] - [3, 5, 6, 2, 9, 7] #=> [1]
````

This gives us the value for the second cell. By continuing the same process we eventually can fill out the entire grid that will look like this.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_9qoMG0O1WE1_p.52567_1378725628450_Screen%20Shot%202013-09-09%20at%2012.20.17.png)

You can see the solution process step by step using the [Sudoku Solver](http://www.sudoku9x9.com/howtosolve.php?level=1).

## Solving an easy sudoku using Ruby

You will implement the algorithm to solve an easy sudoku this week. Let's discuss how to approach the problem.

First, think about the problem in plain English. What classes will you have? So far, describing the game, we spoke about the grid, the cells, the boxes, the rows and columns – all of them are candidates to become classes (not all of them will). What methods will they have? Let's discuss the algorithm in plain English and the answer will be more apparent

- To solve the sudoku puzzle, iterate over every cell in the grid
- For every cell, check if it's filled out
- If it is, skip it
- If it isn't, check what values are possible
- Possible values are computed by taking an array of 1 to 9 and subtracting all values in the same row, same column and same box.
- If only one value is possible, assign it to the cell
- If more than one value is possible, skip this cell
- If you haven't made any changes during the iteration, this isn't an easy sudoku, break out of the cycle
- If you have made the changes but the grid isn't filled out, iterate again
- If the grid is filled out, you found the solution, break out of the cycle

## How to design the class model

The plain English description gives us a very good idea of what methods are going to be. Let's read this line by line.

**To solve the sudoku puzzle, iterate over every cell in the grid**

This implies that we have a grid and the grid has access to its cells to iterate over. Maybe something like

````ruby
class Grid
  def initialize
    @cells = # generate 81 cells...
  end
  attr_reader :cells
end
````

This also means that the grid has a method to solve the puzzle. Something like

````ruby
class Grid
  def solve
  end
end
````

**For every cell, check if it's filled out**

This implies that the cell has an idea about it being filled out or not. Maybe something like:

````ruby
class Cell
  def initialize
    @value = nil
  end
  # returns true if the cell is filled out, false otherwise
  def filled_out?
    # it may be convenient (depending on your design) to use
    # 0 as the "unsolved" value for the cell. This way
    # you won't have to differentiate between numbers and nil
    # values when you calculate neighbours.
  end
end
````

**If it isn't, check what values are possible**

This implies that the cell may be aware of what values are possible. Whether the responsibility for calculating candidate values lie with the cell or the grid is a design decision. I favour putting this code into the cell.

````ruby
class Cell
  def candidates
    
  end
end
````

**Possible values are computed by taking and array 1 to 9 and subtracting all values in the same row, same column and same box.**

This is interesting. So, we decided that the cell should calculate the list of candidates but to do this it needs to have the list of "neighbours", cells in the same row, column and box. The cell needs this information to perform its function. So we should give it to the cell somehow. There are at least two options. The first is to give this information to the initialiser.

````ruby
class Cell
  def initialize(neighbours)
    @neighbours = neighbours # array of cells
  end
end
````

Notice that we're calling this list neighbours, as opposed to cells in the same row, column or box. The reason is that the cell doesn't care at all about whether the these cells are in the same row or column. It only cares that they are somewhere there. From cells point of view, they all could have been in the same column, the computation of the candidates would still be the same.

The second option is to create another method to tell the cell about its neighbours. Whether to do it or not depends on how you decide to structure your code.

A much more interesting question is where this list of candidates is coming from. The class responsible for managing all cells is Grid, so it's logical that the grid knows about the neighbours for every cell.

There are at least two possible options. One is to write a method to determine the list of neighbours given the cell number. Another is to iterate over all rows, cells and boxes and to assign themselves as neighbours to every cell inside them. One of these approaches is easier than the other one. Try to think how you'd implement both of them and choose one of them.

**If only one value is possible, assign it to the cell**

This step tells us that we should be able to assign a value to the cell. Maybe we need an attribute writer for the cell value.

````ruby
class Cell
  attr_writer :value # short for def value=(v); @value=v; end
end
````

But we surely will need to read the cell value as well? For example, to print the resulting solution, we'll need the value of every cell. A better choice would be an attribute accessor:

````ruby
class Cell
  #attr_accessor is short for :attr_reader :value; attr_writer :value
  attr_accessor :value 
end
````

Another good question is where this logic belongs. Surely if the cell is responsible for knowing about its neighbours and calculating possible values, it's only logical to trust it to have the method to solve itself.

````ruby
class Cell
  def solve
    # do nothing if solved
    # request the list of candidates and 
    # get a new value if there's only one possible candidate
  end
end
````

**If more than one value is possible, skip this cell**

**If you haven't made any changes during the iteration, this isn't an easy sudoku, break out of the cycle**

These two steps don't give us any ideas for new methods, this is just the flow control. You may want to maintain a variable to check if any cell was updated. This is an extract from a possible solution. Spend some time understanding how this code works. Think about what the variable **looping** does, why do we need two variables **outstanding** and **outstanding_before**. Think about what happens on line 7 when we assign the result of the comparison. Discuss how this code works in pairs to check that you really understand it.

````ruby
class Grid
  def solve
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      try_to_solve # ask each cell to solve itself
      outstanding         = @cells.count {|c| c.solved? }
      looping             = outstanding_before == outstanding       
      outstanding_before  = outstanding     
    end 
  end
end
````

**If you have made the changes but the grid isn't filled out, iterate again**

This tells us that that the grid must somehow know that it's filled out. Sounds like a method!

````ruby
class Grid
  def solved?
    # a grid is solved if all cells are filled out, maybe using
    # .all? method
  end
end
````

**If the grid if filled out, you found the solution, break out of the cycle**

Ok, so if the grid is filled out, we found the solution. What next? There's a pretty good chance that we'll want to print it on the screen. To do this, it may be a good idea to override the `inspect()` method.

````ruby
class Grid
  def inspect
    # iterate over all cells and print the grid
  end
end
````

Is there anything that we missed? Yes. We've been talking about solving sudoku but we never mentioned how the initial puzzle will be passed to the Grid class. A good idea may be to pass it to the initialiser.

````ruby
class Grid
  def initialize(initial_values)
  end
end
````

Please use the code above only as guidance, don't be afraid to change it as you see fit.

## Time to write some tests

By now you have a good idea of what classes and methods you'll have in your code. Start by writing tests for them. For example, we can test the initialisation of the grid.

````ruby
describe Grid do
  context "initialization" do
    # it's an easy sudoku puzzle, row by row
    let(:puzzle) { '015003002000100906270068430490002017501040380003905000900081040860070025037204600' } 
    let(:grid) { Grid.new(puzzle) }
    it 'should have 81 cells' do
    end
    it 'should have an unsolved first cell' do
    end
    it 'should have a solved second cell with value 1' do
    end
  end
end
````

Given that you have an idea what methods you expect to have and what they should do, start writing tests and implementations for them, one by one. Finally, you'll have a high-level test that checks that sudoku can be solved.

````ruby
describe Grid do
  let(:grid) { #init in here }
  context "solving sudoku" do
    it "can solve the puzzle" do
      expect(grid.solved?).to be_false
      grid.solve
      expect(grid.solved?).to be_true
      expect(grid.to_s).to eq('615493872348127956279568431496832517521746389783915264952681743864379125137254698')
    end
  end
end
````

You know you're done with the task when the test above (or similar) passes and you've got tests for all other methods and classes.

## How to solve hard sudoku

The things are easy if the sudoku is simple, that is, if every cell has a unique solution. Sometimes this is not the case. Consider this grid.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_9qoMG0O1WE1_p.52567_1378725824923_Screen%20Shot%202013-09-09%20at%2012.23.31.png)

If you use the method described above, then you'll fill some of the cells but not all of them. Many cells will be ambiguous, they will have several possible answers. If you're solving sudoku on paper, you may want to write down all possible values for every cell.

![](https://dchtm6r471mui.cloudfront.net/hackpad.com_9qoMG0O1WE1_p.52567_1378726150183_Screen%20Shot%202013-09-09%20at%2012.29.00.png)

In this example, the first cell may be either 1, 4 or 6 but we won't know until we discover the answers for other cells. How do we do this? Let's assume that the first cell has the value 1 and try to solve the puzzle under this assumption.

The second cell in the first row can also have 3 different values. Let's assume (we're hopeful!) it's 4. If we continue the process we will come to one of two outcomes. One option is that our guess was right and we complete the puzzle. The other option is that we'll hit a dead end, when we'll be unable to make any guess at all. At this point we'll know that one of our previous guesses was wrong. However, one sets of guesses will turn out to be right at that will be our solution.

## Human algorithms vs Computer algorithms

If you're an expert sudoku player, you're probably thinking that I must be not aware of a large number of algorithms designed to [solve hard sudoku problems](http://www.sudoku9x9.com/sudoku_solving_techniques_9x9.html). However, many of them have been designed to be used by a person and not a computer.

Humans and computers have fundamentally different capabilities. Humans are good at recognising patterns. Computers are good at number crunching. Humans get bored easily. Computers never get bored. Humans can easily remember faces and experiences. Computers can remember lots of numbers. All these and many other differences must be taken into account when you design an algorithm to solve a particular problem.

For example, consider a hard sudoku puzzle. Humans would never use the algorithm described above to solve it because it would take too much time and it would be incredibly boring. Also, when you assume that a certain cell has a certain value, what do you do with it – pencil it, make a photocopy of the board, something else? Finally, in the hard sudoku example above there are a couple dozen cells with more than one possible values. It would take hundreds, if not thousands of copies to solve sudoku this way.

However, everything changes when you design a computer algorithm. A computer doesn't care that checking thousands of possible solutions is boring. A computer can crunch millions of numbers per second. A computer has a very large memory, so storing lots of possible boards isn't an issue.

## Solving a hard sudoku problem using Ruby

If you have written an algorithm to solve simple sudoku and would like an extra challenge (yes, this will be challenging but fun), extend it to solve a really hard sudoku, for example this one:

````
"800000000003600000070090200050007000000045700000100030001000068008500010090000400"
````

````ruby
'0' * 81
````

On a macbook the algorithm for solving an empty sudoku takes about 4 seconds (it tries a very large number of possible options).

So, how do we update our algorithm to solve a really hard sudoku? First, make sure you're familiar with recursion (:pill: [Recursion](https://github.com/makersacademy/course/blob/master/pills/recursion.md)). This is a classic case of recursion: a hard problem can be broken down into two simpler problems until a base case that is trivial to solve is reached.

The base case in the example will be an easy sudoku. You convert a hard sudoku into an easy sudoku by correctly guessing enough cells, so that the remaining ones could be solved by an _"easy"_ algorithm described above.

As we discussed above, the computer doesn't care how many solutions to check. Let's check every possible assumption and continue checking all variants until we find one that works. Let's say our `solve()` method looks like this.

````ruby
class Grid
  def solve
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      try_to_solve # ask each cell to solve itself
      outstanding         = @cells.count {|c| c.solved? }
      looping             = outstanding_before == outstanding       
      outstanding_before  = outstanding     
    end 
  end
  try_harder unless solved?
end
````

Notice the `try_harder()` method? If we iterate over all cells and we can't make any more changes, we call the method `try_harder()` unless we have found the solution. The `try_harder()` method will implement the algorithm described above.

## Hard problem recursive solution

**Before you continue reading**, try devising the solution yourself. This is hard (trust me, not all _professional_ Ruby developers charging £400/day will be able to do this in an interview).

If you would like to get a general idea of what the method should be, read the code below. You'll still need to fit in some missing parts but the key structure is here. Even if you haven't written it yourself, if you can implement it using this boilerplate and explain how it works, **all coaches will be seriously impressed**.

````ruby
def try_harder
  blank_cell = # select the first unsolved cell
  # by definition, this unsolved cell will have 
  # several possible candidate values
  # Let's explore all of them
  blank_cell.candidates.each do |candidate|
    # let this cell assume this value (we're guessing)
    blank_cell.assume(candidate)
    # the key part: we're replicating the board to create
    # the same board but with the value in the 
    # blank_cell fixed
    # It should be a new instance of the Grid class
    # that will be initialised with the current grid
    board = replicate() # you need to write this method
    # and now let's see if this grid has a solution
    # This is the recursive bit
    board.solve
    # if it does, then we've got a winner
    # Let's steal the solution from there
    # and pretend we found it ourselves :)
    # Since one of the guesses for blank_cell will be correct
    # one of the boards will actually be solved
    # If none are solved, it means we've got an incorrect
    # guess somewhere up the stack trace
    steal_solution(board) and return if board.solved?
  end
end
````

**Good luck!**