require 'Station'

describe Station do
  # let(:station){ double :station}
  station = Station.new("Euston", 1)

it 'is of class Station' do
  expect(station).to be_an_instance_of Station
end

it 'is has a name' do
  expect(station.name).to eq "Euston"
end

it 'it has a zone'do
  expect(station.zone).to eq 1
end







end
