class CargoTrain < Train
  def initialize(number)
    @type = I18n.t('train.cargo.type')

    super
  end

  def add_carriage(carriage)
    unless carriage.instance_of? CargoCarriage
      raise ArgumentError.new(I18n.t('train.cargo.error.message_wrong_type_carriage'))
    end

    super
  end
end
