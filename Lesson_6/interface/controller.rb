class Controller
  include StationInterface
  include TrainInterface
  include ViewsController

  def initialize
    @trains = {}
    @carriages = {}
    @route = Route.new('Москва', 'Петушки')

    @history = [:main_screen]

    # load_translation
  end

  def run
    screen = :main_screen
    screen_vars = {}
    action_vars = {}
    prev_screen = screen

    flash_message(:intro, [:interface])

    loop do
      screen_to_go = nil

      clear_console

      render screen, screen_vars

      user_input = get_user_command

      if (user_input == I18n.t(:back, scope: [:interface, :command])) && (screen != :main_screen)
        screen = prev_screen
      else
        case screen
          when :main_screen
            abort_application if user_input == I18n.t(:exit, scope: [:interface, :command])

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
                if @trains.size > 0
                  screen_to_go = :existing_trains_selection
                else
                  flash_error(:message_no_trains_exists, [:train, :interface])
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
                  flash_error(:message_no_stations_exists, [:station, :interface])
                end

              when '3'
                if stations.size > 0
                  screen_to_go = :stations_list_selection
                else
                  flash_error(:message_no_stations_exists, [:station, :interface])

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

          when :trains_list
            if @trains.keys.include? user_input
              train = @trains[user_input]

              screen_to_go = :train_actions_screen
              action_vars = {train: train}
            else
              flash_error(:message_no_such_train, [:train, :interface])
            end

          when :station_creation_dialog
            if stations.key? user_input
              flash_error(:message_such_station_already_exists, [:station, :interface])
            else
              station = Station.new(user_input)

              stations[user_input] = station
              @route.add_station(station)

              flash_message(:message_station_created, [:station, :interface]) # {station_name: station_name})

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

                flash_message(:message_carriage_added, [:train, :interface])
              when '2'
                if train.carriages.size > 0
                  train.remove_last_carriage
                  flash_message(:message_last_carriage_removed, [:train, :interface])
                else
                  flash_message(:message_no_carriages_in_this_train, [:train, :interface])
                end
              when '3'
                if stations.size > 0
                  screen_to_go = :train_move_to_station_dialog
                else
                  flash_error(:message_no_stations_exists, [:station, :interface])
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

            if @trains.key? train.number
              flash_error(:message_train_already_exists, [:train, :interface])
            else
              @trains[train.number] = train

              action_vars = {train: train}

              flash_message(:message_train_created_successfully, [:train, :interface])#, {train_type: train.class::TYPE, train_number: train.number})
              screen_to_go = :train_actions_screen
            end

          when :stations_list

          when :train_move_to_station_dialog
            train = action_vars[:train]

            if stations.key? user_input
              train.move_to_station(user_input)

              flash_message(:message_train_moved_to_station, [:train, :interface])#, {station_name: user_input})

              screen_to_go = :train_actions_screen #train
            else
              flash_error(:message_no_such_station, [:station, :interface])
            end

          when :stations_list_selection
            if stations.key? user_input
              station = stations[user_input]

              if station.trains_list.size > 0
                screen_to_go = :trains_on_station_list
              else
                flash_error(:message_no_trains_on_this_station, [:station, :interface])
              end
            else
              flash_error(:message_no_such_station, [:station, :interface])
            end

          when :trains_on_station_list
            if stations.size > 0
              screen_to_go = :stations_list_selection

              if stations.key? user_input
                station = stations[user_input]

                if station.trains_list.size > 0
                  screen_to_go = :trains_on_station_list
                else
                  flash_error(:message_no_trains_on_this_station, [:station, :interface])
                end
              else
                flash_error(:message_no_such_station, [:station, :interface])
              end
            else
              flash_error(:message_no_stations_exists, [:station, :interface])

              screen_to_go = :station_action_selection
            end
        end

        unless screen_to_go.nil?
          prev_screen = screen
          screen = screen_to_go
          @history << prev_screen
        end
      end
    end
  end

  # private
  # def load_translation
  #   require 'i18n'
  #
  #   messages_file = File.join(File.dirname(__FILE__), 'i18n', 'messages.yml')
  #   messages = YAML.load_file(messages_file)
  #
  #   I18n.config.available_locales = :ru
  #   I18n.locale = :ru
  #   I18n.backend.store_translations(:ru , messages)
  # rescue
  #   raise 'Что-то не так с файлом сообщений!'
  # end

  def get_user_command
    gets.chomp
  end

  def stations
    @route.stations_list
  end

  private
  def abort_application
    abort I18n.t(:exit, scope: [:interface])
  end
end
