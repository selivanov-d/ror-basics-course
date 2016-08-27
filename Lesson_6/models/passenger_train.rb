class PassengerTrain < Train
  def initialize(number)
    @type = I18n.t('train.passenger.type')

    super
  end

  def add_carriage(carriage)
    unless carriage.instance_of? PassengerCarriage
      raise ArgumentError.new(I18n.t('train.passenger.error.message_wrong_type_carriage'))
    end

    super
  end
end
