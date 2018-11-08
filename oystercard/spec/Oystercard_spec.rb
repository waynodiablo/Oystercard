require 'Oystercard'

describe Oystercard do
  let(:station){ double :station}

  it 'has a new card balance of 0' do
    expect(subject.balance).to eq 0
  end

  context 'requires top_up' do
    before (:each) do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    end
    it 'deducts an amount from the balance' do
      expect{ subject.touch_out }.to change{ subject.balance }.by -1
    end
    it 'does not allow a #top_up beyond a max' do
      expect { subject.top_up(10) }.to raise_error "That would exceed the maximum limit of £#{subject.max_balance}"
    end
    it 'changes in_journey to true' do
      subject.touch_in(station)
      expect(subject.in_journey?).to be_truthy
    end
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

        it 'stored the entry station at touch-in' do
          subject.touch_in("Bank")
          expect(subject.entry_station).to eq "Bank"
        end


        context 'touching-out' do
          it 'changes in_journey to false after a journey' do
            subject.touch_in(station)
            expect{ subject.touch_out }.to change{ subject.in_journey }.from(true).to(false)
          end

          context 'requires journey to be in progress' do
            it 'deducts min fare from balance' do
              subject.touch_in(station)
              expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MIN_FARE)
            end
          end
        end
      end
    end
  end
  it 'cannot travel without a minimum balance' do
    expect{ subject.touch_in(station) }.to raise_error("You must have £#{subject.min_fare} balance")
  end
  it 'changes the balance with #top_up' do
    expect{ subject.top_up(10) }.to change{
      subject.balance }.by 10
  end
end
