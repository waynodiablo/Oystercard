require 'Oystercard'

describe Oystercard do
  let(:entry_station){ double :station}
  let(:exit_station){ double :station}

  it 'has a new card balance of 0' do
    expect(subject.balance).to eq 0
  end

  context 'requires top_up' do
    before (:each) do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    end
    it 'deducts an amount from the balance' do
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -1
    end
    it 'does not allow a #top_up beyond a max' do
      expect { subject.top_up(10) }.to raise_error "That would exceed the maximum limit of £#{subject.max_balance}"
    end
    # it 'changes in_journey to true' do
    #   subject.touch_in(entry_station)
    #   expect(subject.in_journey?).to be_truthy
    # end
    it 'does not allow a #top_up beyond a max' do
      expect { subject.top_up(10) }.to raise_error "That would exceed the maximum limit of £#{subject.max_balance}"
    end

    context 'travelling' do
      it 'can report on journey status' do
        expect(subject.in_journey?).to eq false
      end

      context 'touching-in' do
        it 'can touch-in' do
          expect(subject).to respond_to(:touch_in)
        end

        # it 'stored the entry station at touch-in' do
        #   subject.touch_in(entry_station)
        #   expect(subject.entry_station).to eq entry_station
        # end

        it 'creates an empty journey history' do
          expect(subject.journey_history).to be_empty
        end

        it 'stores a record of my entry station' do
          subject.touch_in("Bank")
          expect(subject.journey_history.last[:start]).to eq "Bank"
        end

        context 'touching-out' do
          it 'changes the entry_station to nil on touch-out' do
            subject.touch_in(entry_station)
            subject.touch_out(exit_station)
            expect(subject.entry_station).to eq nil
          end

          it 'stores a record of my journey upon touch-out' do
            subject.touch_in("Euston")
            subject.touch_out("Bank")
            expect(subject.journey_history).to include({start: "Euston", end: "Bank"})
          end


          context 'requires journey to be in progress' do
            it 'deducts min fare from balance' do
              subject.touch_in(entry_station)
              expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MIN_FARE)
            end
          end
        end
      end
    end
  end
  it 'cannot travel without a minimum balance' do
    expect{ subject.touch_in(entry_station) }.to raise_error("You must have £#{subject.min_fare} balance")
  end
  it 'changes the balance with #top_up' do
    expect{ subject.top_up(10) }.to change{
      subject.balance }.by 10
  end
end
