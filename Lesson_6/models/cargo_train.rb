class CargoTrain < Train
  TYPE = I18n.t(:type, scope: [:train, :cargo])

  def add_carriage(carriage)
    unless carriage.instance_of? CargoCarriage
      raise StandardError.new(I18n.t(:message_wrong_type_carriage, scope: [:train, :cargo, :error]))
    end

    super
  end
end
