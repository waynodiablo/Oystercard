feature 'member of public accesses bike' do
  scenario 'docking station releases working bike' do
    station = DockingStation.new
    bike = station.release_bike
    expect(bike).to be_working
  end
end
