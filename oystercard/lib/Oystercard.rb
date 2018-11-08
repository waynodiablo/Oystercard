class Oystercard
DEFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90
MIN_FARE = 1
attr_accessor :balance, :in_journey, :entry_station
attr_reader :max_balance, :min_fare


  def initialize(balance = DEFAULT_BALANCE, max_balance = MAXIMUM_BALANCE, min_fare = MIN_FARE)
    @balance = balance
    @max_balance = max_balance
    @min_fare = min_fare
    # @in_journey = false
  end

  def top_up(amount)
    if (@balance + amount) <= max_balance
      @balance += amount
    else
      raise "That would exceed the maximum limit of £#{@max_balance}"
    end
  end

  private def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise ("You must have £#{MIN_FARE} balance") if balance < MIN_FARE
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(min_fare)
  end




  # class end
end
