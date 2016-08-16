class Station
  attr_reader :name

  def initialize(name)
    abort 'Для создания нужно указать её название!' unless name.instance_of? String

    @name = name
    @trains_list = {}
  end

  def take_train_in(train)
    abort 'Станция может принимать только поезда!' unless train.instance_of? Train

    @trains_list[train.number] = train
  end

  def remove_train(train)
    abort 'Удалить можно только поезд!' unless train.instance_of? Train

    train.current_station = nil
    @trains_list.delete train.number

    train
  end

  def print_trains_list(type = nil)
    if type.nil?
      if @trains_list.size > 0
        puts "На станции #{@name} находится #{@trains_list.size} поезд(а|ов):"
        @trains_list.each_value do |train|
          puts train
        end
      else
        puts "На станции #{@name} сейчас нет ни одного поезда."
      end
    else
      abort 'Тип поезда можно указать только строкой!' unless type.is_a? String

      trains_list_by_type = @trains_list.values.inject([]) do |list, train|
        if train.type == type
          list << train.number
        else
          list
        end
      end

      if trains_list_by_type.size > 0
        puts "На станции #{@name} находится #{trains_list_by_type.size} поезд(а|ов) с типом \"#{type}\":"
        puts trains_list_by_type
      else
        puts "На станции #{@name} нет поездов с типом \"#{type}\":"
      end
    end
  end

  def to_s
    @name
  end
end
