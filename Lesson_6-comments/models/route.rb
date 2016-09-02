class Route < Model
  attr_reader :start_station, :finish_station

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station

    puts @start_station.inspect
    puts @finish_station.inspect

    @in_between_stations = {}

    validate!
  end

  def add_station(station)
    raise ArgumentError.new(get_message({path: [:route, :error, :message_wrong_station_type_given]})) unless station.instance_of? Station

    if stations_list.keys.include? station.name
      raise RuntimeError.new(get_message({path: [:station, :error, :message_such_station_already_exists], vars: {station_name: station.name}}))
    end

    @in_between_stations[station.name] = station

    @full_stations_list = nil
  end

  def stations_list
    @full_stations_list ||= {}

    if @full_stations_list.empty?
      @full_stations_list[@start_station.name] = @start_station

      @in_between_stations.each_value do |station|
        @full_stations_list[station.name] = station
      end

      @full_stations_list[@finish_station.name] = @finish_station
    end

    @full_stations_list
  end

  def get_station_by_name(name)
    stations_list[name]
  end

  def to_s
    stations_list.keys.join "\n"
  end

  def delete_station(name)
    unless @in_between_stations.keys.include? name
      raise RuntimeError.new(get_message({path: [:station, :error, :message_cannot_delete_station]}))
    end

    @in_between_stations.delete name
  end

  private
  def validate!
    unless stations_list.values.all? { |station| station.instance_of? Station }
      raise RuntimeError.new(get_message({path: [:route, :validation, :wrong_station_type_in_route]}))
    end
  end
end
