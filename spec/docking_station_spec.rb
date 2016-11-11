require 'docking_station'

describe DockingStation do

  it {is_expected.to respond_to(:release_bike)}

  it 'expects bike to be working' do
  	bike = Bike.new
  	expect(bike.working?).to eq true
  end
  it {is_expected.to respond_to(:dock).with(1).argument}

  it "expects bike to be docked" do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.docked_bikes).to include(bike)
  end

  it "expects true if there is any bike in a docked_bike array" do
    bike = Bike.new
    subject.dock(bike)
    expect(subject.any_bikes_docked?).to eq true
  end

  it 'if docked_bikes is empty, expect release_bike to raise error' do
    docked_bikes = []
    expect {subject.release_bike}.to raise_error("There are no more bikes!")
  end

  it "should return full station error if station is full and we try to dock a bike" do
    bike=Bike.new
    DockingStation::DEFAULT_CAPACITY.times{subject.dock(bike)}
    expect {subject.dock(bike)}.to raise_error("Docking station is full")
  end

  it "expects the capacity to be default unless argument given" do
      station = DockingStation.new()
      expect(station.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  it "expects the capacity to be set by the argument given" do
    station = DockingStation.new(10)
    expect(station.capacity).to eq 10
  end

  let(:bike) { double :bike }
  it 'reports bike as broken bike' do
    allow(bike).to receive(:report_bike).and_return(true)
    allow(bike).to receive(:broken?).and_return(true)
    new_bike = bike
    new_bike.report_bike
    expect(new_bike).to be_broken
  end

  it 'wont allow broken bikes to be released' do
    bike = Bike.new
    bike.report_bike
    station = DockingStation.new
    station.dock(bike)
    expect{station.release_bike}.to raise_error("That bike is broken!")
  end
end
