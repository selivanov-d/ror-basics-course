module StationInterface
  private
  def show_station_action_selection_dialog
    loop do
      DispatcherInterfaceHelper.clear_console
      puts 'Со станциями можно сделать следующее:'

      DispatcherInterfaceHelper.generate_menu({1 => 'Добавить станцию', 2 => 'Список станций', 3 => 'Посмотреть список поездов на станции'})

      DispatcherInterfaceHelper.print_back_button_and_prompt

      command = gets.chomp

      show_main_screen if command == DispatcherInterfaceHelper::COMMANDS[:back]

      command = command.to_i

      case command
        when 1
          show_station_creation_dialog
          break
        when 2
          show_stations_list
          break
        when 3
          show_station_train_list
          break
        else
          DispatcherInterfaceHelper.flash_error
      end
    end
  end

  def show_station_creation_dialog
    loop do
      DispatcherInterfaceHelper.clear_console

      puts 'Какое название будет у станции?'

      DispatcherInterfaceHelper.print_back_button_and_prompt

      station_name = gets.chomp

      show_station_action_selection_dialog if station_name == DispatcherInterfaceHelper::COMMANDS[:back]

      if stations.key? station_name
        DispatcherInterfaceHelper.flash_error 'Такая станция уже существует!'
      else
        @route.add_station(station_name)

        DispatcherInterfaceHelper.flash_message "Станция #{station_name} создана!"

        show_station_action_selection_dialog

        break
      end
    end
  end

  def show_stations_list
    DispatcherInterfaceHelper.clear_console

    if stations.size > 0
      loop do
        DispatcherInterfaceHelper.clear_console

        puts 'Существуют следующие станции:'

        @route.stations_list.each_value do |station|
          puts station
        end

        DispatcherInterfaceHelper.print_back_button_and_prompt

        command = gets.chomp

        if command == DispatcherInterfaceHelper::COMMANDS[:back]
          show_station_action_selection_dialog
          break
        else
          DispatcherInterfaceHelper.flash_error
        end
      end
    else
      DispatcherInterfaceHelper.flash_error 'Пока что не создано ни одной станции!'

      show_station_action_selection_dialog
    end
  end

  def show_station_train_list
    DispatcherInterfaceHelper.clear_console

    loop do
      DispatcherInterfaceHelper.clear_console

      if stations.size > 0
        puts 'Выберите станцию на которой вы хотите посмотреть список поездов:'

        stations.each_value do |station|
          puts station
        end

        DispatcherInterfaceHelper.print_back_button_and_prompt

        station_name = gets.chomp

        show_station_action_selection_dialog if station_name == DispatcherInterfaceHelper::COMMANDS[:back]

        if stations.key? station_name
          DispatcherInterfaceHelper.clear_console

          station = stations[station_name]

          if station.trains_list.size > 0
            puts 'На станции находятся следующие поезда:'

            station.trains_list.each_value do |train|
              puts train
            end

            DispatcherInterfaceHelper.print_back_button_and_prompt

            command = gets.chomp

            show_station_action_selection_dialog if command == DispatcherInterfaceHelper::COMMANDS[:back]

            break
          else
            DispatcherInterfaceHelper.flash_error 'На этой станции нет ни одного поезда.'
          end
        else
          DispatcherInterfaceHelper.flash_error 'Нет такой станции!'
        end
      else
        DispatcherInterfaceHelper.flash_error 'Пока что не создано ни одной станции!'

        show_station_action_selection_dialog
      end
    end
  end
end
