class Route
  attr_reader :start_station, :finish_station

  def initialize(start_station_name, finish_station_name)
    # validate!

    @start_station = Station.new start_station_name
    @finish_station = Station.new finish_station_name
    @in_between_stations = {}
  end

  def add_station(name)
    raise I18n.t(:message_such_station_already_exists, scope: [:station, :error]) if stations_list.keys.include? name

    @in_between_stations[name] = Station.new name

    @full_stations_list = nil
  end

  def stations_list
    @full_stations_list ||= {}

    if @full_stations_list.empty?
      @full_stations_list[@start_station.name] = @start_station

      @in_between_stations.each do |station_name, station|
        @full_stations_list[station_name] = station
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
    raise I18n.t(:message_cannot_delete_station, scope: [:station, :error]) unless @in_between_stations.keys.include? name

    @in_between_stations.delete name
  end

  # private
  # def validate!
  #   unless [start_station_name, finish_station_name].all? { |name| name.instance_of? String }
  #     abort 'Для создания начальной и конечной станции маршрута нужно указать их названия!'
  #   end
  # end
end
