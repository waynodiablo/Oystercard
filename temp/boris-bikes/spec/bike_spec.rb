class Bike

  def working?
    true
  end

end

describe Bike do
  it { is_expected.to respond_to :working? }

  describe 'working?' do
    it 'returns true' do
      expect(subject).to be_working
    end
  end
end