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
    DispatcherInterfaceHelper.flash_message "--- Симулятор РЖД ---\nТолько плацкарт, только хардкор!!!"

    show_main_screen
  end

  def stations
    @route.stations_list
  end

  # по сути, все методы, рисующие интерфейсы, будут приватными, чтобы их нельзя было вызывать ниоткуда, кроме метода DispatcherInterface.run -- единой точки входа в программу
  # та же история с подключаемыми модулями-интерфейсами
  private
  def show_main_screen
    loop do
      DispatcherInterfaceHelper.clear_console

      puts 'Возможные действия:'

      DispatcherInterfaceHelper.generate_menu({1 => 'Управление поездами', 2 => 'Управление станциями'})

      DispatcherInterfaceHelper.print_exit_button_and_prompt

      command = gets.chomp

      DispatcherInterfaceHelper.clear_console

      abort 'Спасибо, что воспользовались услугами нашей системы! Ту-ту!!!' if command == DispatcherInterfaceHelper::COMMANDS[:exit]

      command = command.to_i

      case command
        when 1
          show_train_action_selection_dialog
          break
        when 2
          show_station_action_selection_dialog
          break
        else
          DispatcherInterfaceHelper.flash_error
      end
    end
  end
end
