require 'docking_station'

describe DockingStation do

  it {is_expected.to respond_to(:release_bike)}

  let(:bike) { double :bike }
  it 'expects bike to be working' do
    allow(bike).to receive(:working?).and_return(true)
  	new_bike = bike
  	expect(bike.working?).to eq true
  end
  it {is_expected.to respond_to(:dock).with(1).argument}

  it "expects bike to be docked" do
    new_bike = bike
    subject.dock(new_bike)
    expect(subject.docked_bikes).to include(new_bike)
  end

  it "expects true if there is any bike in a docked_bike array" do
    new_bike = bike
    subject.dock(bike)
    expect(subject.any_bikes_docked?).to eq true
  end

  it 'if docked_bikes is empty, expect release_bike to raise error' do
    docked_bikes = []
    expect {subject.release_bike}.to raise_error("There are no more bikes!")
  end

  it "should return full station error if station is full and we try to dock a bike" do
    new_bike = bike
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

  it 'reports bike as broken bike' do
    allow(bike).to receive(:report_bike).and_return(true)
    allow(bike).to receive(:broken?).and_return(true)
    new_bike = bike
    new_bike.report_bike
    expect(new_bike).to be_broken
  end

  it 'wont allow broken bikes to be released' do
    allow(bike).to receive(:report_bike).and_return(true)
    allow(bike).to receive(:broken?).and_return(true)
    new_bike = bike
    bike.report_bike
    station = DockingStation.new
    station.dock(bike)
    expect{station.release_bike}.to raise_error("That bike is broken!")
  end
end
