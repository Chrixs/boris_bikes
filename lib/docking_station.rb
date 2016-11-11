require './lib/bike.rb'

class DockingStation
  attr_reader :docked_bikes, :capacity
  DEFAULT_CAPACITY = 20
  def initialize(capacity = DEFAULT_CAPACITY)
    @docked_bikes = []
    @capacity = capacity
  end

  def release_bike
    raise "There are no more bikes!" if empty?
    raise "That bike is broken!" if @docked_bikes[0].broken?
    @docked_bikes.shift
  end



  def dock(new_bike)
      raise "Docking station is full" if full?
      @docked_bikes << new_bike

  end

  def any_bikes_docked?
    @docked_bikes.any?
  end

  private
    def full?
      @docked_bikes.length == DEFAULT_CAPACITY
    end


    def empty?
      @docked_bikes.empty?
    end
end
