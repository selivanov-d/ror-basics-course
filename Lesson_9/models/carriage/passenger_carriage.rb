class Carriage::PassengerCarriage < Carriage
  attr_reader :total_seats, :seats_taken

  validate :number, :format, NUMBER_FORMAT
  validate :total_seats, :positive_number

  def initialize(total_seats)
    @total_seats = total_seats.to_i

    @seats_taken = 0

    super()
  end

  def take_seats(amount)
    amount = amount.to_i

    if amount <= 0
      raise ArgumentError, I18n.t('carriage.error.wrong_seats_input_type_given')
    end
    raise I18n.t('carriage.passenger.error.insufficient_seats') if (seats_free - amount) < 0

    @seats_taken += amount
  end

  def seats_free
    @total_seats - @seats_taken
  end

  def type
    I18n.t('train.passenger.type')
  end
end
