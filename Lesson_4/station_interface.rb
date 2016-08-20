module StationInterface
  private
  def show_station_action_selection_dialog
    valid_command = false

    until valid_command
      InterfaceHelper.clear_console
      puts 'Со станциями можно сделать следующее:'

      InterfaceHelper.generate_menu({1 => 'Добавить станцию', 2 => 'Список станций', 3 => 'Посмотреть список поездов на станции'})

      InterfaceHelper.print_back_button_and_prompt

      command = gets.chomp

      show_main_screen if command == InterfaceHelper::COMMANDS[:back]

      command = command.to_i

      case command
        when 1
          valid_command = true
          show_station_creation_dialog
        when 2
          valid_command = true
          show_stations_list
        when 3
          valid_command = true
          show_station_train_list
        else
          InterfaceHelper.flash_error
      end
    end
  end

  def show_station_creation_dialog
    valid_command = false

    until valid_command
      InterfaceHelper.clear_console

      puts 'Какое название будет у станции?'

      InterfaceHelper.print_back_button_and_prompt

      station_name = gets.chomp

      show_station_action_selection_dialog if station_name == InterfaceHelper::COMMANDS[:back]

      if stations.key? station_name
        InterfaceHelper.flash_error 'Такая станция уже существует!'
      else
        valid_command = true

        @route.add_station(station_name)

        InterfaceHelper.flash_message "Станция #{station_name} создана!"

        show_station_action_selection_dialog
      end
    end
  end

  def show_stations_list
    InterfaceHelper.clear_console

    valid_command = false

    if stations.size > 0
      until valid_command
        InterfaceHelper.clear_console

        puts 'Существуют следующие станции:'

        @route.stations_list.each_value do |station|
          puts station
        end

        InterfaceHelper.print_back_button_and_prompt

        command = gets.chomp

        if command == InterfaceHelper::COMMANDS[:back]
          valid_command = true
          show_station_action_selection_dialog
        else
          InterfaceHelper.flash_error
        end
      end
    else
      InterfaceHelper.flash_error 'Пока что не создано ни одной станции!'

      show_station_action_selection_dialog
    end
  end

  def show_station_train_list
    InterfaceHelper.clear_console

    valid_command = false

    until valid_command
      InterfaceHelper.clear_console

      if stations.size > 0
        puts 'Выберите станцию на которой вы хотите посмотреть список поездов:'

        stations.each_value do |station|
          puts station
        end

        InterfaceHelper.print_back_button_and_prompt

        station_name = gets.chomp

        show_station_action_selection_dialog if station_name == InterfaceHelper::COMMANDS[:back]

        if stations.key? station_name
          InterfaceHelper.clear_console

          station = stations[station_name]

          if station.trains_list.size > 0
            puts 'На станции находятся следующие поезда:'

            station.trains_list.each_value do |train|
              puts train
            end

            InterfaceHelper.print_back_button_and_prompt

            command = gets.chomp

            valid_command = true

            show_station_action_selection_dialog if command == InterfaceHelper::COMMANDS[:back]
          else
            InterfaceHelper.flash_error 'На этой станции нет ни одного поезда.'
          end
        else
          InterfaceHelper.flash_error 'Нет такой станции!'
        end
      else
        InterfaceHelper.flash_error 'Пока что не создано ни одной станции!'

        show_station_action_selection_dialog
      end
    end
  end
end
