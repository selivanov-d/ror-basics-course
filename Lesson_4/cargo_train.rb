class CargoTrain < Train
  TYPE = 'Грузовой'

  def add_carriage(carriage)
    abort 'К грузовому поезду можно прицепить только грузовые вагоны!' unless carriage.instance_of? CargoCarriage

    super.add_carriage(carriage)
  end
end
