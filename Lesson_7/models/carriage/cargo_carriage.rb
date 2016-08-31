class Carriage::CargoCarriage < Carriage
  attr_reader :total_space, :space_taken

  def initialize(total_space)
    @total_space = total_space.to_f

    unless @total_space > 0
      raise ArgumentError, I18n.t('carriage.cargo.error.wrong_input_space_type')
    end

    @space_taken = 0

    super()
  end

  def take_space(amount)
    amount = amount.to_f

    if amount <= 0
      raise ArgumentError, I18n.t('carriage.cargo.error.wrong_seats_input_type_given')
    end
    raise I18n.t('carriage.cargo.error.insufficient_space') if (space_free - amount) < 0

    @space_taken += amount
  end

  def space_free
    @total_space - @space_taken
  end

  def type
    I18n.t('train.cargo.type')
  end
end
