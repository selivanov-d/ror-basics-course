class Train < Model
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^[\w\dа-я]{3}-?[\w\dа-я]{2}$/i

  attr_reader :carriages, :number, :route
  attr_writer :current_station

  @@instances = {}

  def initialize(number)
    @number = number

    validate!

    @carriages = []
    @current_speed = 0
    @current_station = nil
    @route = nil

    @@instances[self.number] = self

    register_instance
  end

  def accelerate(delta)
    unless (delta.is_a? Numeric) && (delta > 0)
      raise ArgumentError.new(get_message({path: [:train, :validation, :wrong_acceleration_delta_given]}))
    end

    @current_speed += delta
  end

  def stop
    @current_speed = 0
  end

  def add_carriage(carriage)
    raise RuntimeError.new(get_message({path: [:train, :error, :message_carriage_attach_error]})) if moves?

    @carriages << carriage
  end

  def remove_last_carriage
    raise RuntimeError.new(get_message({path: [:train, :error, :message_carriage_detach_error]})) if moves?

    @carriages = @carriages[0...-1]
  end

  def moves?
    @current_speed > 0
  end

  def move_to_station(name)
    unless route_set? || station_in_route?(name)
      raise RuntimeError.new(get_message({path: [:train, :error, :given_station_not_found_in_route]}))
    end

    depart_from_station
    arrive_to_station(name)
  end

  def route=(route)
    raise ArgumentError.new(get_message({path: [:train, :error, :wrong_route_format_given]})) unless route.instance_of? Route

    unless @route.nil?
      unless @current_station.name == route.start_station.name
        raise RuntimeError.new(get_message({path: [:train, :error, :cannot_assign_new_route_wrong_start_station]}))
      end
    end

    @route = route

    @current_station = @route.start_station
    @route.start_station.take_train_in(self)
  end

  def station_in_route?(name)
    @route.stations_list.keys.include? name
  end

  def route_set?
    defined? @route
  end

  def to_s
    "#{@number} -- #{self.class::TYPE}"
  end

  def self.find(number)
    @@instances[number]
  end

  def self.instances
    @@instances
  end

  private
  def depart_from_station
    station = @route.get_station_by_name(@current_station.name)
    station.remove_train(self)
  end

  def arrive_to_station(name)
    station = @route.get_station_by_name(name)
    station.take_train_in(self)

    @current_station = @route.stations_list[name]
  end

  def validate!
    if (@number =~ NUMBER_FORMAT) == nil
      raise RuntimeError.new(get_message({path: [:train, :validation, :wrong_number_format]}))
    end
  end
end
