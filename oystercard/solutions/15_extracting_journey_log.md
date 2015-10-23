- [ ] test drive the development of JourneyLog class
- [ ] use dependency injection to inject a journey_klass
```ruby
class JourneyLog
  def initialize(journey_klass: )
    @journey_klass = journey_klass
    @journeys = []
  end
```
- [ ] `#start_journey` should start a new journey with an entry station
Here is an example of how you might write the tests:

```ruby
require 'journey_log'
describe JourneyLog do

  let(:journey){ double :journey } #this may need to have some methods
  let(:station){ double :station }
  let(:journey_klass){double :journey_klass, new: journey}
  subject {described_class.new(journey_klass: journey_klass)}

  describe '#start_journey' do
    it 'starts a journey' do
      expect(journey_klass).to receive(:new).with(entry_station: station)
      subject.start_journey(station)
    end

    it 'records a journey' do
      allow(journey_klass).to receive(:new).and_return journey
      subject.start_journey(station)
      expect(subject.journeys).to include journey
    end
  end
  ```

- [ ] a private method `#current_journey` should return an incomplete journey or create a new journey

You could achieve this like so:

```ruby
private
def current_journey
  incomplete_journey || journey_klass.new
end
```

- [ ] `#exit_journey` should add a new exit station to the `current_journey`
- [ ] `#journeys` should return a list of all previous journeys without exposing the internal array to external modification

One issue with using an attr_reader when for an instance variable that is an array, is that the attr_reader allows you to modify that array. To prevent this, return a `.dup` like so:
```ruby
def journeys
  @journeys.dup
end
```
- [ ] `#outstanding_charges` should close an incomplete journey and return its fare

There are many ways to do this. We used a simple conditional:
```ruby
def outstanding_charges
  incomplete_journey ? incomplete_journey.exit.fare : NO_CHARGES
end
```

- [ ] refactor to using Forwardable module from Standard Library to delegate the method `#exit_journey` to the `current_journey`'s `#exit` method.

```ruby
class JourneyLog
  extend Forwardable

  def_delegator :current_journey, :exit, :exit_journey
```

Discuss with your partner what is happening here - why is this helpful?

- [ ] remove redundant code from OysterCard class

Your Oystercard should now only send messages to the JourneyLog. Although it does pass instances of station around, station is never aware of OysterCards existence. OysterCard should never communicate directly with Journey.
