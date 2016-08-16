class Train
  attr_accessor :current_station, :route
  attr_reader :number, :type, :carriage_count, :current_speed

  TYPES = {
    freight: 'Грузовой',
    passenger: 'Пассажирский'
  }

  def initialize(number, type, carriage_count)
    abort 'Имя поезда должно быть строкой или числом!' unless self.class.valid_name?(number)
    abort 'Неизвестный тип поезда! Поезда бывают только грузовые и пассажирские.' unless self.class.valid_type? type
    abort 'Количество вагонов должно быть больше или равно нулю!' unless carriage_count.to_i >= 0

    @number = number
    @type = type
    @carriage_count = carriage_count.to_i
    @current_speed = 0
    @current_station = nil
    @route = nil
  end

  def accelerate(delta)
    unless (delta.is_a? Numeric) && (delta > 0)
      abort 'Увеличение скорости можно задавать только положительным числом!'
    end

    @current_speed += delta
  end

  def stop
    @current_speed = 0
  end

  def add_carriage
    abort 'Нельзя прицепить вагон к движущемуся поезду!' if moves?

    @carriage_count += 1
  end

  def remove_carriage
    abort 'Нельзя отцепить вагон от движущегося поезда!' if moves?
    abort 'Нечего отцеплять! В поезде уже нет вагонов.' unless @carriage_count > 0

    @carriage_count -= 1
  end

  def moves?
    @current_speed > 0
  end

  def move_to_station(name)
    unless route_set? && station_in_route?(name)
      abort "Поезд #{@number} не может поехать на станцию #{name}, т.к. её нет в его маршруте!"
    end

    depart_from_station
    arrive_to_station(name)
  end

  def route=(route)
    abort 'Поезду нужен маршрут правильного формата!' unless route.instance_of? Route

    if @route.nil?
      @route = route
    else
      unless @current_station.name == route.start_station.name
        abort 'Нельзя присвоить поезду новый маршрут если он не начинается со станции, на которой поезд находится!'
      end

      @route = route
    end

    @current_station = @route.start_station
    @route.start_station.take_train_in(self)
  end

  def self.valid_name?(name)
    (name.instance_of? String) || (name.to_i > 0)
  end

  def self.valid_type?(type)
    Train::TYPES.values.include? type
  end

  def to_s
    "#{@number} -- #{@type}"
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

  def station_in_route?(name)
    @route.stations_list.keys.include? name
  end

  def route_set?
    @route.instance_of? Route
  end
end
