class Train < BaseModel
  include Manufacturer
  include InstanceCounter

  NUMBER_FORMAT = /^[\w\dа-я]{3}-?[\w\dа-я]{2}$/i

  attr_reader :carriages, :number, :route, :type
  attr_writer :current_station

  attr_accessor_with_history :test

  @@created = {}

  def initialize(number)
    @number = number

    @carriages = []
    @current_speed = 0
    @current_station = nil
    @route = nil

    @@created[number] = self

    register_instance

    validate!
  end

  def accelerate(delta)
    unless (delta.is_a? Numeric) && (delta > 0)
      raise ArgumentError, I18n.t('train.validation.wrong_acceleration_delta_given')
    end

    @current_speed += delta
  end

  def stop
    @current_speed = 0
  end

  def add_carriage(carriage)
    raise I18n.t('train.error.message_carriage_attach_error') if moves?

    @carriages << carriage
  end

  def remove_last_carriage
    raise I18n.t('train.error.message_carriage_detach_error') if moves?
    raise I18n.t('train.interface.message_no_carriages_in_this_train') if @carriages.size.zero?

    @carriages = @carriages[0...-1]
  end

  def moves?
    @current_speed > 0
  end

  def move_to_station(name)
    unless route_set? || station_in_route?(name)
      raise I18n.t('train.error.given_station_not_found_in_route', train_number: number, station_name: name)
    end

    depart_from_station
    arrive_to_station(name)
  end

  def route=(route)
    raise ArgumentError, I18n.t('train.error.wrong_route_format_given') unless route.instance_of? Route

    unless @route.nil?
      unless @current_station.name == route.start_station.name
        raise I18n.t('train.error.cannot_assign_new_route_wrong_start_station')
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
    "#{@number} -- #{type}"
  end

  def self.find(number)
    @@created[number]
  end

  def self.all
    @@created
  end

  def self.each_created
    @@created.each_value do |train|
      yield(train)
    end
  end

  def each_carriage
    @carriages.each do |carriage|
      yield(carriage)
    end
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
end
