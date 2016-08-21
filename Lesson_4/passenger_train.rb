class PassengerTrain < Train
  TYPE = 'Пассажирский'

  def add_carriage(carriage)
    abort 'К пассажирскому поезду можно прицепить только пассажирские вагоны!' unless carriage.instance_of? PassengerCarriage

    super
  end
end
