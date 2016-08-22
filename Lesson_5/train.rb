class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :carriages, :number, :route
  attr_writer :current_station

  @@trains = {}

  def initialize(number)
    abort 'Имя поезда должно быть строкой или числом!' unless self.class.valid_name?(number)

    @number = number
    @carriages = []
    @current_speed = 0
    @current_station = nil
    @route = nil

    @@trains[self.number] = self

    register_instance
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

  def add_carriage(carriage)
    abort 'Нельзя прицепить вагон к движущемуся поезду!' if moves?

    @carriages << carriage
  end

  # не уверен, что есть смысл заморачиваться с возможностью выбора конкретного вагона для удаления
  # посему, упростил себе задачи и этот метод просто удаляет последний вагон из поезда
  def remove_last_carriage
    abort 'Нельзя отцепить вагон от движущегося поезда!' if moves?

    @carriages = @carriages[0...-1]
  end

  def moves?
    @current_speed > 0
  end

  def move_to_station(name)
    unless route_set? || station_in_route?(name)
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
    @@trains[number]
  end

  # нижеследующие методы вызываются только из Train.move_to_station
  # сделано так для того, чтобы нельзя было добавить поезд на станцию не удалив предварительно с текущей
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
