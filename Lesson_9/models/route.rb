class Route < BaseModel
  attr_reader :start_station, :finish_station

  validate :start_station, :type, Station
  validate :finish_station, :type, Station

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station

    @in_between_stations = {}

    validate!
  end

  def add_station(station)
    raise ArgumentError, I18n.t('route.error.message_wrong_station_type_given') unless station.instance_of? Station

    if stations_list.keys.include? station.name
      raise I18n.t('station.error.message_such_station_already_exists', station_name: station.name)
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
      raise I18n.t('station.error.message_cannot_delete_station')
    end

    @in_between_stations.delete name
  end
end
