require 'Station'

describe Station do
  # let(:station){ double :station}
subject {described_class.new("Euston",1)}

# it 'is of class Station' do
#   expect(subject).to be_an_instance_of Station
# end

it 'is has a name' do
  expect(subject.name).to eq("Euston")
end

it 'it has a zone' do
  expect(subject.zone).to eq(1)
end

end
