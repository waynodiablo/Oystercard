require 'Oystercard'

describe Oystercard do

it 'has a new card balance of 0' do
  expect(subject.balance).to eq 0
end

it 'can topped up multiple times' do
  subject.top_up(10)
  expect(subject.top_up(50)).to eq 60
end

it 'changes the balance with #top_up' do
  expect{ subject.top_up(10) }.to change{
    subject.balance }.by 10
end

it 'does not allow a #top_up beyond a max' do
  subject.balance = 90
  expect { subject.top_up(10) }.to raise_error "That would exceed the maximum limit of £#{subject.max_balance}"
end




end
