class Oystercard
DEFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90
attr_accessor :balance
attr_reader :max_balance

  def initialize(balance = DEFAULT_BALANCE, max_balance = MAXIMUM_BALANCE)
    @balance = balance
    @max_balance = max_balance
  end

  def top_up(amount)
    # balance= (+= amount)
    if (@balance + amount) <= max_balance
      @balance += amount
    else
      raise "That would exceed the maximum limit of £#{@max_balance}"
    end
  end




  # class end
end
