class DispatcherInterface
  include StationInterface
  include TrainInterface
  include DispatcherInterfaceHelper

  require 'yaml'

  # В этом методе делаю фэйковый маршрут-заглушку, чтобы не усложнять и без того большой интерфейс.
  def initialize
    @trains = {}
    @carriages = {}
    @route = Route.new('Москва', 'Петушки')
    @messages = YAML.load_file 'messages.yml'
  end

  def run
    flash_message(%w(interface intro))

    show_main_screen
  end

  def stations
    @route.stations_list
  end

  # по сути, все методы, рисующие интерфейсы, будут приватными, чтобы их нельзя было вызывать ниоткуда, кроме метода DispatcherInterface.run -- единой точки входа в программу
  # та же история с подключаемыми модулями-интерфейсами
  private
  def get_user_command
    gets.chomp
  end

  def show_main_screen
    loop do
      clear_console

      print_message(%w(interface header_possible_actions))

      generate_menu({1 => get_message(%w(interface button_trains_management)), 2 => get_message(%w(interface button_stations_management))})

      print_exit_button_and_prompt

      command = get_user_command

      clear_console

      abort get_message(%w(interface exit)) if command == get_message(%w(interface command exit))

      command = command.to_i

      case command
        when 1
          show_train_action_selection_dialog
          break
        when 2
          show_station_action_selection_dialog
          break
        else
          flash_error
      end
    end
  end
end
