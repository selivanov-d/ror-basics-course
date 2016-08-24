class Station
  include InstanceCounter
  include Validator

  attr_reader :name, :trains_list

  @@stations = []

  def initialize(name)
    @name = name

    validate!

    @trains_list = {}

    @@stations << self

    register_instance
  end

  def take_train_in(train)
    raise I18n.t(:message_wrong_train_type, scope: [:station, :error]) unless train.is_a? Train

    @trains_list[train.number] = train
  end

  def remove_train(train)
    abort 'Удалить можно только поезд!' unless train.is_a? Train

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
      raise 'Тип поезда можно указать только строкой!' unless type.is_a? String

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

  def self.all
    @@stations
  end

  def to_s
    @name
  end

  private
  def validate!
    # if (@name =~ /^[а-я]{3,50}/i) == nil
    #   raise 'Название станции не соответствует стандарту!'
    # end
  end
end
