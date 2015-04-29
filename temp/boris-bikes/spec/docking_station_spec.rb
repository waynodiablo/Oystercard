class DockingStation
  def release_bike
    Bike.new
  end
end

describe DockingStation do
  it { is_expected.to respond_to :release_bike }
end
