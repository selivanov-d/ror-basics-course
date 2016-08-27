class ApplicationController
  include Views

  # не придумал, как можно сделать навигацию по экранам без того, чтобы задать весь маршрут вручную
  SCREENS_MAP = {
      main_screen: [:train_action_selection, :station_action_selection],
      train_action_selection: [:new_train_type_selection, :existing_trains_selection],
      new_train_type_selection: [:new_train_creation_dialog],

      existing_trains_selection: [:train_actions_screen],
      train_actions_screen: [:train_move_to_station_dialog],

      station_action_selection: [:station_creation_dialog, :stations_list, :stations_list_selection],
      station_creation_dialog: [:station_action_selection],
      stations_list: [:station_action_selection],
      stations_list_selection: [:trains_on_station_list],
  }

  def initialize
    @route = Route.new(Station.new('Москва'), Station.new('Петушки'))
  end

  def run
    screen = :main_screen
    screen_vars = {}
    action_vars = {}

    flash_message(I18n.t('interface.intro'))

    begin
      loop do
        clear_console

        screen_to_go = nil

        render screen, screen_vars

        screen_vars = {}

        user_input = get_user_command

        if (user_input == I18n.t('interface.command.back')) && (screen != :main_screen)
          screen = find_back_screen screen
        else

          case screen
            when :main_screen
              abort_application if user_input == I18n.t('interface.command.exit')

              case user_input
                when '1'
                  screen_to_go = :train_action_selection
                when '2'
                  screen_to_go = :station_action_selection
                else
                  flash_error
              end
            when :train_action_selection
              case user_input
                when '1'
                  screen_to_go = :new_train_type_selection
                when '2'
                  if Train.all.size > 0
                    screen_to_go = :existing_trains_selection
                  else
                    flash_error(I18n.t('train.interface.message_no_trains_exists'))
                  end
                else
                  flash_error
              end
            when :station_action_selection
              case user_input
                when '1'
                  screen_to_go = :station_creation_dialog
                when '2'
                  if stations.size > 0
                    screen_to_go = :stations_list
                  else
                    flash_error(I18n.t('station.interface.message_no_stations_exists'))
                  end

                when '3'
                  if stations.size > 0
                    screen_to_go = :stations_list_selection
                  else
                    flash_error(I18n.t('station.interface.message_no_stations_exists'))

                    screen_to_go = :station_action_selection
                  end
                else
                  flash_error
              end
            when :new_train_type_selection
              case user_input
                when '1'
                  screen_to_go = :new_train_creation_dialog
                  action_vars = {type: :passenger_train}
                when '2'
                  screen_to_go = :new_train_creation_dialog
                  action_vars = {type: :cargo_train}
                else
                  flash_error
              end
            when :existing_trains_selection
              if Train.all.keys.include? user_input
                train = Train.all[user_input]

                screen_to_go = :train_actions_screen
                action_vars = {train: train}
                screen_vars = {train_name: train.number}
              else
                flash_error(I18n.t('train.interface.message_no_such_train'))
              end
            when :station_creation_dialog
              if stations.key? user_input
                flash_error(I18n.t('station.interface.message_such_station_already_exists'))
              else
                station = Station.new(user_input)

                @route.add_station(station)

                flash_message(I18n.t('station.interface.message_station_created', station_name: station.name))

                screen_to_go = :station_action_selection
              end
            when :train_actions_screen
              train = action_vars[:train]

              case user_input
                when '1'
                  case train
                    when CargoTrain
                      carriage = CargoCarriage.new
                    when PassengerTrain
                      carriage = PassengerCarriage.new
                  end

                  train.add_carriage(carriage)

                  flash_message(I18n.t('train.interface.message_carriage_added'))

                  screen_vars = {train_name: train.number}
                when '2'
                  if train.carriages.size > 0
                    train.remove_last_carriage
                    flash_message(I18n.t('train.interface.message_last_carriage_removed'))
                  else
                    flash_message(I18n.t('train.interface.message_no_carriages_in_this_train'))
                  end

                  screen_vars = {train_name: train.number}
                when '3'
                  screen_vars = {train_name: train.number}
                  if stations.size > 0
                    screen_to_go = :train_move_to_station_dialog
                  else
                    flash_error(I18n.t('station.interface.message_no_stations_exists'))
                  end
                else
                  flash_error
              end

            when :new_train_creation_dialog
              case action_vars[:type]
                when :passenger_train
                  train = PassengerTrain.new(user_input)
                when :cargo_train
                  train = CargoTrain.new(user_input)
              end

              train.route = @route

              flash_message(I18n.t('train.interface.message_train_created_successfully', train_type: train.type, train_number: train.number))

              screen_to_go = :train_actions_screen
              action_vars = {train: train}
              screen_vars = {train_name: train.number}

            when :stations_list
              flash_error

            when :train_move_to_station_dialog
              train = action_vars[:train]

              screen_vars = {train_name: train.number}
              action_vars = {train: train}

              if stations.key? user_input
                train.move_to_station(user_input)

                flash_message(I18n.t('train.interface.message_train_moved_to_station', station_name: user_input))

                screen_to_go = :train_actions_screen
              else
                flash_error(I18n.t('station.interface.message_no_such_station'))
              end

            when :stations_list_selection
              if stations.key? user_input
                station = stations[user_input]

                if station.trains_list.size > 0
                  screen_to_go = :trains_on_station_list
                  screen_vars = {station: station}
                else
                  flash_error(I18n.t('station.interface.message_no_trains_on_this_station'))
                end
              else
                flash_error(I18n.t('station.interface.message_no_such_station'))
              end

            when :trains_on_station_list
              if stations.size > 0
                screen_to_go = :stations_list_selection

                if stations.key? user_input
                  station = stations[user_input]

                  if station.trains_list.size > 0
                    screen_to_go = :trains_on_station_list
                  else
                    flash_error(I18n.t('station.interface.message_no_trains_on_this_station'))
                  end
                else
                  flash_error(I18n.t('station.interface.message_no_such_station'))
                end
              else
                flash_error(I18n.t('station.interface.message_no_stations_exists'))

                screen_to_go = :station_action_selection
              end
          end

          screen = screen_to_go unless screen_to_go.nil?
        end
      end

    rescue *[RuntimeError, ArgumentError] => e
      flash_error(e.message)
      retry
    end
  end

  def get_user_command
    gets.chomp
  end

  def stations
    @route.stations_list
  end

  private
  def abort_application
    abort I18n.t('interface.exit')
  end

  def find_back_screen(current_screen)
    map_part_hash = SCREENS_MAP.find do |key, value|
      value.include? current_screen
    end

    map_part_hash[0]
  end
end
