# Oystercard Challenge

This week's challenge will start with going back over the basics we covered last
week in Boris Bikes, giving you the chance to reinforce what you learned last
week. You'll then be challenged to build a more complex system which should
really stretch your skills in Code Design, Ruby, RSpec and Object-Oriented Programming.

## User Stories

Here are the user stories you will be working on for this project:

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers.
As a customer
I need to touch in and out.

In order to pay for my journey
As a customer
I need to have the minimum amout for a single journey.

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from
```

## Set up the project:

  * [Create a Gemfile](01_create_gemfile.md)
  * [Create RSpec conventional files](02_initialise_rspec.md)
  * [Review debugging basics](03_debugging.md)

## Create a basic Oyster card:
  * [Add the balance](04_adding_balance.md)
  * [Enable top up functionality](05_top_up.md)
  * [Enforce maximum balance](06_maximum_balance.md)
  * [Deduct the money](07_deducting_money.md)

## Add touch in/out functionality:
  * [Add touch in/out support](08_touch_in_out.md)
  * [Checking mininum balance on touch in](09_min_balance_on_touch_in.md)
  * [Charging for the journey](10_charge_on_touch_out.md)

## Record the journeys
  * [Saving the entry station](11_saving_entry_station.md)
  * [Adding journey history](12_journey_history.md)
  * [Creating the station class](13_create_station_class.md)

## Refactor to extract Journey class
  * [Handling a journey without a touch out](14_no_touch_in_or_out.md)

## Refactoring: get the code into shape
  * [Extracting the journey log out of the Oystercard](15_extracting_journey_log.md)

## Make fares depends on zones
  * [Calculating the fare between zones](16_fare_for_zones.md)
