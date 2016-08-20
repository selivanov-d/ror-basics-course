module StationInterface
  private
  def show_station_action_selection_dialog
    loop do
      clear_console
      print_message(%w(station interface header_actions_options))

      generate_menu({1 => get_message(%w(station interface button_create_station)), 2 => get_message(%w(station interface button_stations_list)), 3 => get_message(%w(station interface button_station_trains_list))})

      print_back_button_and_prompt

      command = get_user_command

      show_main_screen if command == get_message(%w(interface command back))

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
          flash_error
      end
    end
  end

  def show_station_creation_dialog
    loop do
      clear_console

      print_message(%w(station interface header_new_station))

      print_back_button_and_prompt

      station_name = get_user_command

      show_station_action_selection_dialog if station_name == get_message(%w(interface command back))

      if stations.key? station_name
        flash_error(%w(station interface message_such_station_already_exists))
      else
        @route.add_station(station_name)

        flash_message(%w(station interface message_station_created), {station_name: station_name})

        show_station_action_selection_dialog

        break
      end
    end
  end

  def show_stations_list
    clear_console

    if stations.size > 0
      loop do
        clear_console

        print_message(%w(station interface header_following_stations_exists))

        @route.stations_list.each_value do |station|
          puts station
        end

        print_back_button_and_prompt

        command = get_user_command

        if command == get_message(%w(interface command back))
          show_station_action_selection_dialog
          break
        else
          flash_error
        end
      end
    else
      flash_error(%w(station interface message_no_stations_exists))

      show_station_action_selection_dialog
    end
  end

  def show_station_train_list
    loop do
      clear_console

      if stations.size > 0
        print_message(%w(station interface header_choose_station_for_trains_list))

        stations.each_value do |station|
          puts station
        end

        print_back_button_and_prompt

        station_name = get_user_command

        show_station_action_selection_dialog if station_name == get_message(%w(interface command back))

        if stations.key? station_name
          clear_console

          station = stations[station_name]

          if station.trains_list.size > 0
            print_message(%w(station interface header_trains_list))

            station.trains_list.each_value do |train|
              puts train
            end

            print_back_button_and_prompt

            command = get_user_command

            show_station_action_selection_dialog if command == get_message(%w(interface command back))

            break
          else
            flash_error(%w(station interface message_no_trains_on_this_station))
          end
        else
          flash_error(%w(station interface message_no_such_station))
        end
      else
        flash_error(%w(station interface message_no_stations_exists))

        show_station_action_selection_dialog
      end
    end
  end
end
