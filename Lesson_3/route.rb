class Route
  attr_reader :start_station, :finish_station

  def initialize(start_station_name, finish_station_name)
    unless (start_station_name.class == String) && (finish_station_name.class == String)
      abort 'Для создания начальной и конечной станции маршрута нужно указать их названия!'
    end

    @start_station = Station.new start_station_name
    @finish_station = Station.new finish_station_name
    @in_between_stations = {}
  end

  def add_station(name)
    abort "Станция \"#{name}\" уже есть в этом маршруте!" if stations_list.keys.include? name

    @in_between_stations[name] = Station.new name
  end

  def stations_list
    full_stations_list = {}

    full_stations_list[@start_station.name] = @start_station

    @in_between_stations.each do |station_name, station|
      full_stations_list[station_name] = station
    end

    full_stations_list[@finish_station.name] = @finish_station
    full_stations_list
  end

  def get_station_by_name(name)
    stations_list[name]
  end

  # написать, что намучался с методом
  def to_s
    result = []

    stations_list.each_key do |station_name|
      result << station_name
    end

    result.join "\n"
  end

  def delete_station(name)
    abort 'Такой станции нет в маршруте либо это крайняя станция и удалить её нельзя!' unless @in_between_stations.keys.include? name

    @in_between_stations.delete name
  end
end
