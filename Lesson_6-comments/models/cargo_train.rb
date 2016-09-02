class CargoTrain < Train
  def initialize(number)
    @type = get_message({path: [:train, :cargo, :type]})

    super
  end

  def add_carriage(carriage)
    unless carriage.instance_of? CargoCarriage
      raise ArgumentError.new(get_message({path: [:train, :cargo, :error, :message_wrong_type_carriage]}))
    end

    super
  end
end
