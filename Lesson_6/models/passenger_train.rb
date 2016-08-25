class PassengerTrain < Train
  TYPE = get_message({path: [:train, :passenger, :type]})

  def add_carriage(carriage)
    unless carriage.instance_of? PassengerCarriage
      raise ArgumentError.new(get_message({path: [:train, :passenger, :error, :message_wrong_type_carriage]}))
    end

    super
  end
end
