class Station
  attr_reader :name

  def initialize(name)
    abort 'Для создания нужно указать её название!' unless name.class == String

    @name = name
    @trains_list = {}
  end

  def take_train_in(train)
    abort 'Станция может принимать только поезда!' unless train.class == Train

    @trains_list[train.number] = train
  end

  def remove_train(train)
    abort 'Удалить можно только поезд!' unless train.class == Train

    train.current_station = nil
    @trains_list.delete train.number

    train
  end

  def print_trains_list_by_type(type)
    abort 'Тип поезда можно указать только строкой!' unless Train.valid_name?(type)

    trains_list_by_type = @trains_list.values.inject([]) do |list, train|
       if train.type == type
         list << train
       else
         list
       end
    end

    if trains_list_by_type.size > 0
      puts "На станции #{@name} находится #{trains_list_by_type.size} поезд(а|ов) с типом \"#{type}\":"
      trains_list_by_type.each do |train|
        puts train.number
      end
    else
      puts "На станции #{@name} нет поездов с типом \"#{type}\":"
    end
  end

  def print_trains_list
    if @trains_list.size > 0
      puts "На станции #{@name} находится #{@trains_list.size} поезд(а|ов):"
      @trains_list.each_value do |train|
        puts train
      end
    else
      puts "На станции #{@name} сейчас нет ни одного поезда."
    end
  end

  def to_s
    @name
  end
end

=begin
Комментарии:
в некоторых моментах немного отошёл от буквы задания. Так, у меня не станция отправляет поезд, а сам поезд отправляется со станции. Считаю, что так логичнее с точки зрения реального мира -- станция может дать команду поезду поехать до определённой станции (вызвать метод Train.move_to_station), а уж машинист поезда сделает (или не сделает) всё необходимое для этого (вызовет методы Train.depart_from_station и Train.arrive_to_station). :)

Неожиданно столкнулся с проблемой распечатки маршрута: puts Route отрабатывал неожиданно для меня, если метод Route.to_s возвращал не строку. Если он возвращал Array, то превращение его в строку, как я ожидал, не происходило. Проблему решил, но не уверен, что правильным способом. Вообще не уверен, что правильно полагаться на to_s.

В качестве реакции на невалидные данные использую abort. Наверное, правильнее будет использовать что-то другое, например, exception, но, вроде бы, это будет темой одного из грядущих уроков, так что я не стал заморачиваться с этим сейчас.

Вопросы:
- как правильно организовывать код методов, которые должны печатать данные? Держать puts внутри метода или делать так, чтобы они возвращали данные, подготовленные для печати? Т.е
    class Station
      def print_list
        puts '1, 2, 3'
      end
    end

    Station.new.print_list

    или

    class Station
      def list
        '1, 2, 3'
      end
    end

    puts Station.new.list

  В задании сказано, что методы должны печатать, так что где-то оставил как в первом варианте.

- можно ли как-то возвращать изменять переданное значение в метод? Например, у меня есть метод Station.remove_train куда передаётся экземпляр класса Train. В методе я этот инстанс изменяю и возвращаю. Красиво было бы если бы изменённый Train возвращался бы в место вызова. В PHP есть возможность передачи по ссылке, в Ruby, насколько я понял, такого нет.

- безопасно ли использовать для данных, которым важен порядок, хэш? В хэше у меня хранится список станций маршрута и всё, вроде бы работает так, как я ожидаю (сохраняется порядок добавления станций в маршрут), но есть сомнение, что это правильный подход.
=end

