# Inheritance

One strategy is inheritance. [OOP](https://github.com/makersacademy/course/blob/master/boris_bikes.md) allows classes to "subclass" from each other, inheriting the common functionality. Consider this example.

```ruby
class Car
  def initialize(make)
      @make = make
  end
  
  def start
    puts "#{@make} starting..."
    check_brakes
    engine.start
  end
end

class ElectricCar < Car
  def engine
    ElectricEngine.new
  end
end
 
class InternalCombustionCar < Car
  def engine
    InternalCombustionEngine.new
  end
end
```

` ElectricCar.new("Tesla").start #=> Tesla starting... `

` InternalCombustionCar.new("Ford").start #=> Ford starting... `

Some of the methods and classes mentioned above (check_brakes, ElectricEngine, etc.) are not defined in the code. This code sample is incomplete but it does show that some methods (e.g. check_brakes) could be common to all subclasses of Car, while the implementation of some methods (e.g. engine) could differ. 

![Tracking pixel](https://githubanalytics.herokuapp.com/course/pills/inheritance.md)
