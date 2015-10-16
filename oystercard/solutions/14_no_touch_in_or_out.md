- [ ] Update your test suite to reflect a new Journey class
Make a new spec file journey_spec.rb
- [ ] Create a new class Journey and move the functionality that relates to a journey from Oystercard to Journey
Test drive the development of your journey class. Each journey should have an entry and an exit station. Instances of journey should be initialized with an entry station, and should respond to `#exit`, `#fare` and `#complete` methods.
- [ ] Make sure all tests pass, all existing functionality is preserved
You will need to send messages to your Journey class from your Oystercard class - remember to use doubles to test that the correct messages are being sent.
- [ ] The `#fare` method should return the correct fare, or the penalty fare of 6 if there was either no `entry_station` or no `exit_station`.

Remember to test all the different combinations of zones. You may need to write some private methods to keep your external interface clean.

- [ ] Make sure the entire codebase is DRY
- [ ] Make sure all methods are three lines or shorter

Here is an example of a spec file for a journey class - there are many ways to make this work, this is only one.

```ruby
require 'journey'
describe Journey do
  let(:station) { double :station, zone: 1}

  it { is_expected.to respond_to(:entry_station)}
  it { is_expected.to respond_to(:exit_station)}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(subject.exit(station)).to eq(subject)
  end

  context 'given an entry station' do
    subject {described_class.new(entry_station: station)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it "returns a penalty fare if no exit station given" do
      subject.exit
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it "completes journey if exit with no station given" do
      subject.exit
      expect(subject).to be_complete
    end

    context 'given an exit station' do
      let(:other_station) { double :other_station }

      before do
        subject.exit(other_station)
      end

      it 'calculates a fare for zone 1 to zone 1' do
        update_zones(1,1)
        expect(subject.fare).to eq 1
      end

      it 'calculates a fare for zone 1 to zone 2' do
        update_zones(1,2)
        expect(subject.fare).to eq 2
      end

      it 'calculates a fare for zone 6 to zone 5' do
        update_zones(6,5)
        expect(subject.fare).to eq 2
      end

      it 'calculates a fare for zone 6 to zone 1' do
        update_zones(6,2)
        expect(subject.fare).to eq 5
      end

      it "knows if a journey is complete" do
        expect(subject).to be_complete
      end

      def update_zones(entry_zone, exit_zone)
        allow(station).to receive(:zone).and_return(entry_zone)
        allow(other_station).to receive(:zone).and_return(exit_zone)
      end
    end
  end
end
```
