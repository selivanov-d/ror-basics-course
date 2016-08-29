class Train::PassengerTrain < Train
  def initialize(number)
    @type = I18n.t('train.passenger.type')

    super
  end

  def add_carriage(carriage)
    unless carriage.instance_of? Carriage::PassengerCarriage
      raise ArgumentError, I18n.t('train.passenger.error.message_wrong_type_carriage')
    end

    super
  end
end
