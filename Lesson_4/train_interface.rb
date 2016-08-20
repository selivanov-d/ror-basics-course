module TrainInterface
  private
  def show_new_train_type_selection_dialog
    InterfaceHelper.clear_console

    type = nil

    loop do
      InterfaceHelper.clear_console

      puts 'Какой тип поезда хотите создать?'

      InterfaceHelper.generate_menu({1 => 'Пассажирский', 2 => 'Грузовой'})

      InterfaceHelper.print_back_button_and_prompt

      command = gets.chomp

      show_train_action_selection_dialog if command == InterfaceHelper::COMMANDS[:back]

      command = command.to_i

      case command
        when 1
          type = :passenger_train
          break
        when 2
          type = :cargo_train
          break
        else
          InterfaceHelper.flash_error
      end
    end

    show_new_train_creation_dialog(type)
  end

  def show_new_train_creation_dialog(type)
    train = nil

    loop do
      InterfaceHelper.clear_console

      puts 'Укажите номер нового поезда:'
      InterfaceHelper.print_back_button_and_prompt

      train_number = gets.chomp

      show_new_train_type_selection_dialog if train_number == InterfaceHelper::COMMANDS[:back]

      case type
        when :passenger_train
          train = PassengerTrain.new(train_number)
        when :cargo_train
          train = CargoTrain.new(train_number)
      end

      train.route = @route

      if @trains.key? train.number
        InterfaceHelper.flash_error 'Такой поезд уже существует!'
      else
        @trains[train.number] = train
        break
      end
    end

    InterfaceHelper.flash_message "#{train.class::TYPE} поезд номер #{train.number} успешно создан!"

    show_train_action_selection_dialog
  end

  def show_train_action_selection_dialog
    InterfaceHelper.clear_console

    puts 'С поездами можно сделать:'

    loop do
      InterfaceHelper.generate_menu({1 => 'Создать поезд', 2 => 'Выбрать существующий поезд'})

      InterfaceHelper.print_back_button_and_prompt

      command = gets.chomp

      show_main_screen if command == InterfaceHelper::COMMANDS[:back]

      command = command.to_i

      case command
        when 1
          show_new_train_type_selection_dialog
          break
        when 2
          show_existing_trains_selection_dialog
          break
        else
          puts 'Неизвестная команда'
      end
    end
  end

  def show_train_actions_screen(train)
    loop do
      InterfaceHelper.clear_console
      puts "Вы выбрали поезд #{train}."
      puts 'Что хотите сделать с этим поездом?'

      InterfaceHelper.generate_menu({1 => 'Прицепить к нему вагон', 2 => 'Отцепить от него вагон', 3 => 'Направить на станцию'})

      InterfaceHelper.print_back_button_and_prompt

      command = gets.chomp

      show_existing_trains_selection_dialog if command == InterfaceHelper::COMMANDS[:back]

      command = command.to_i

      case command
        when 1
          case train
            when CargoTrain
              carriage = CargoCarriage.new
            when PassengerTrain
              carriage = PassengerCarriage.new
          end

          train.add_carriage(carriage)

          InterfaceHelper.flash_message 'Вагон прицеплен!'
        when 2
          InterfaceHelper.clear_console

          if train.carriages.size > 0
            train.remove_last_carriage
            puts 'Последний вагон отцеплен!'
          else
            puts 'В этом поезде уже нет вагонов!'
          end

          sleep 1
        when 3
          show_train_move_to_station_dialog(train)

          break
        else
          InterfaceHelper.flash_error
      end
    end
  end

  def show_existing_trains_selection_dialog
    InterfaceHelper.clear_console

    if @trains.size > 0
      loop do
        InterfaceHelper.clear_console

        puts 'Выберите один из стоящих под парами поездов по его номеру:'

        @trains.each_value do |train|
          puts train
        end

        InterfaceHelper.print_back_button_and_prompt

        train_number = gets.chomp

        show_train_action_selection_dialog if train_number == InterfaceHelper::COMMANDS[:back]

        if @trains.keys.include? train_number
          train = @trains[train_number]

          puts train.class

          show_train_actions_screen(train)
          break
        else
          InterfaceHelper.flash_error 'Такого поезда нет!'
        end
      end
    else
      InterfaceHelper.flash_error 'Нет ни одного поезда!'

      show_train_action_selection_dialog
    end
  end

  def show_train_move_to_station_dialog(train)
    InterfaceHelper.clear_console

    if stations.size > 0
      puts 'На какую станцию отправить поезд?'

      stations.each_value do |station|
        puts station
      end

      InterfaceHelper.print_back_button_and_prompt

      command = gets.chomp

      if stations.key? command
        train.move_to_station(command)

        InterfaceHelper.flash_message "Поезд перемещён на станцию #{command}"

        show_train_actions_screen(train)
      else
        InterfaceHelper.flash_error 'Такой станции не существует!'

        show_train_move_to_station_dialog(train)
      end
    else
      InterfaceHelper.flash_error 'Пока что никаких станций не создано!'

      show_train_actions_screen(train)
    end
  end
end
