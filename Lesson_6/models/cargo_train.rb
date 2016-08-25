class CargoTrain < Train
  TYPE = get_message({path: [:train, :cargo, :type]})

  def add_carriage(carriage)
    unless carriage.instance_of? CargoCarriage
      raise ArgumentError.new(get_message({path: [:train, :cargo, :error, :message_wrong_type_carriage]}))
    end

    super
  end
end
