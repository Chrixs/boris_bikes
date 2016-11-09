require_relative "./bike"

class DockingStation
  attr_reader :docked_bikes

  def initialize
    @docked_bikes = []
  end

  def release_bike
    raise "Docking station is empty" if empty?
    @docked_bikes.pop
  end

  def dock(bike)
    raise "Docking station is full" if full?
    @docked_bikes << bike
    @docked_bikes.any?
  end
  
  private

    def empty?
      @docked_bikes.empty?
    end

    def full?
      @docked_bikes.count == 20
    end
end
