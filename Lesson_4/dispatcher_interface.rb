class DispatcherInterface
  include StationInterface
  include TrainInterface

  # В этом методе делаю фэйковый маршрут-заглушку, чтобы не усложнять и без того большой интерфейс.
  def initialize
    @trains = {}
    @carriages = {}
    @route = Route.new('Москва', 'Петушки')
  end

  def run
    InterfaceHelper::flash_message "--- Симулятор РЖД ---\nТолько плацкарт, только хардкор!!!"

    show_main_screen
  end

  def stations
    @route.stations_list
  end

  # по сути, все методы, рисующие интерфейсы, будут приватными, чтобы их нельзя было вызывать ниоткуда, кроме метода DispatcherInterface.run -- единой точки входа в программу
  # та же история с подключаемыми модулями-интерфейсами
  private
  def show_main_screen
    valid_command = false

    until valid_command
      InterfaceHelper::clear_console

      puts 'Возможные действия:'

      InterfaceHelper::generate_menu({1 => 'Управление поездами', 2 => 'Управление станциями'})

      InterfaceHelper::print_exit_button_and_prompt

      command = gets.chomp

      abort 'Спасибо, что воспользовались услугами нашей системы! Ту-ту!!!' if command == InterfaceHelper::COMMANDS[:exit]

      command = command.to_i

      case command
        when 1
          show_train_action_selection_dialog
          valid_command = true
        when 2
          show_station_action_selection_dialog
          valid_command = true
        else
          InterfaceHelper::flash_error
      end
    end
  end
end
