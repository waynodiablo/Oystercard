Set up the project:
  Create a Gemfile: create_gemfile
  Create RSpec conventional files: initialise_rspec
  Learn debugging basics: debugging

Create a basic Oyster card:
  Add the balance: adding_balance
  Enable top up functionality: top_up
  Enforce maximum balance: maximum_balance
  Deduct the money: deducting_money
  Enforce minimum balance: minimum_balance

Add touch in/out functionality:
  Add touch in/out support: touch_in_out
  Checking mininum balance on touch in: min_balance_on_touch_in
  Charging for the journey: charge_on_touch_out

Record the journeys
  Saving the entry station: saving_entry_station
  Adding journey history: journey_history
  Adding to the journey history: create_station_class 

Refactor to extract Journey class
  Handling a journey without a touch out: no_touch_out
Make fares depends on zones
  Calculating the fare between zones: fare_for_zones
  Penalty fare for incomplete zones: penalty_fare

Refactoring: get the code into shape
  Teasing the Journey class out of the Oystercard: creating_journey_class
