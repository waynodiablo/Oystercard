class Oystercard
DEFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90
MIN_FARE = 1
attr_accessor :balance, :in_journey
attr_reader :max_balance, :min_fare


  def initialize(balance = DEFAULT_BALANCE, max_balance = MAXIMUM_BALANCE, min_fare = MIN_FARE)
    @balance = balance
    @max_balance = max_balance
    @in_journey = false
    @min_fare = min_fare
  end

  def top_up(amount)
    # balance= (+= amount)
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
    @in_journey
  end

  def touch_in
    raise ("You must have £#{MIN_FARE} balance") if balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(min_fare)
  end




  # class end
end
