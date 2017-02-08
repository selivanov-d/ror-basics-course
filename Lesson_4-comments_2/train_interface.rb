module TrainInterface
  private
  def show_new_train_type_selection_dialog
    clear_console

    type = nil

    loop do
      clear_console

      print_message(%w(train interface header_what_train_type_to_create))

      generate_menu({1 => get_message(%w(train passenger type)), 2 => get_message(%w(train cargo type))})

      print_back_button_and_prompt

      command = get_user_command

      show_train_action_selection_dialog if command == get_message(%w(interface command back))

      command = command.to_i

      case command
        when 1
          type = :passenger_train
          break
        when 2
          type = :cargo_train
          break
        else
          flash_error
      end
    end

    show_new_train_creation_dialog(type)
  end

  def show_new_train_creation_dialog(type)
    train = nil

    loop do
      clear_console

      print_message(%w(train interface header_enter_new_train_number))

      print_back_button_and_prompt

      train_number = get_user_command

      show_new_train_type_selection_dialog if train_number == get_message(%w(interface command back))

      case type
        when :passenger_train
          train = PassengerTrain.new(train_number)
        when :cargo_train
          train = CargoTrain.new(train_number)
      end

      train.route = @route

      if @trains.key? train.number
        flash_error(%w(train interface message_train_already_exists))
      else
        @trains[train.number] = train
        break
      end
    end

    flash_message(%w(train interface message_train_created_successfully), {train_type: train.class::TYPE, train_number: train.number})

    show_train_action_selection_dialog
  end

  def show_train_action_selection_dialog
    clear_console

    print_message(%w(train interface header_trains_action_selection))

    loop do
      generate_menu({1 => get_message(%w(train interface button_create_new_train)), 2 => get_message(%w(train interface button_pick_existing_train))})

      print_back_button_and_prompt

      command = get_user_command

      show_main_screen if command == get_message(%w(interface command back))

      command = command.to_i

      case command
        when 1
          show_new_train_type_selection_dialog
          break
        when 2
          show_existing_trains_selection_dialog
          break
        else
          flash_error
      end
    end
  end

  def show_train_actions_screen(train)
    loop do
      clear_console
      print_message(%w(train interface header_you_choose_train),  {train_name: train.number})
      print_message(%w(train interface header_action_selection))

      generate_menu({1 => get_message(%w(train interface button_add_carriage)), 2 => get_message(%w(train interface button_remove_carriage)), 3 => get_message(%w(train interface button_send_to_station))})

      print_back_button_and_prompt

      command = get_user_command

      show_existing_trains_selection_dialog if command == get_message(%w(interface command back))

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

          flash_message(%w(train interface message_carriage_added))
        when 2
          clear_console

          if train.carriages.size > 0
            train.remove_last_carriage
            print_message(%w(train interface message_last_carriage_removed))
          else
            print_message(%w(train interface message_no_carriages_in_this_train))
          end

          sleep 1
        when 3
          show_train_move_to_station_dialog(train)

          break
        else
          flash_error
      end
    end
  end

  def show_existing_trains_selection_dialog
    clear_console

    if @trains.size > 0
      loop do
        clear_console

        print_message(%w(train interface header_choose_train))

        @trains.each_value do |train|
          puts train
        end

        print_back_button_and_prompt

        train_number = get_user_command

        show_train_action_selection_dialog if train_number == get_message(%w(interface command back))

        if @trains.keys.include? train_number
          train = @trains[train_number]

          puts train.class

          show_train_actions_screen(train)
          break
        else
          flash_error(%w(train interface message_no_such_train))
        end
      end
    else
      flash_error(%w(train interface message_no_trains_exists))

      show_train_action_selection_dialog
    end
  end

  def show_train_move_to_station_dialog(train)
    clear_console

    if stations.size > 0
      print_message(%w(train interface header_choose_station_for_train_to_send))

      stations.each_value do |station|
        puts station
      end

      print_back_button_and_prompt

      command = get_user_command

      if stations.key? command
        train.move_to_station(command)

        flash_message(%w(train interface message_train_moved_to_station), {station_name: command})

        show_train_actions_screen(train)
      else
        flash_error(%w(station interface message_no_such_station))

        show_train_move_to_station_dialog(train)
      end
    else
      flash_error(%w(station interface message_no_stations_exists))

      show_train_actions_screen(train)
    end
  end
end
