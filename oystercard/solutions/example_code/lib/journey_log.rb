require 'forwardable'
class JourneyLog
  extend Forwardable

  def_delegator :current_journey, :exit, :exit_journey

  NO_CHARGE = 0

  def initialize(journey_klass: )
    @journey_klass = journey_klass
    @journeys = []
  end

  def start_journey(station)
    fail 'Already in a Journey.' if current_journey.entry_station
    add(journey_klass.new(entry_station: station))
  end

  def journeys
    @journeys.dup
  end

  def outstanding_charges 
    incomplete_journey ? incomplete_journey.exit.fare : NO_CHARGE
  end

  private
  attr_reader :journey_klass

  def incomplete_journey
    journeys.reject(&:complete?).first
  end

  def current_journey
    incomplete_journey || journey_klass.new
  end

  def add(journey)
    @journeys << journey
  end

end
