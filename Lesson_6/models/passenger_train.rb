class PassengerTrain < Train
  TYPE = 'Пассажирский'

  def add_carriage(carriage)
    unless carriage.instance_of? PassengerCarriage
      raise StandardError.new(I18n.t(:message_wrong_type_carriage, scope: [:train, :passenger, :error]))
    end

    super
  end
end
