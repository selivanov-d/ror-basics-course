module Views
  include ViewsHelper

  @@screen_vars = {}

  def render(view_name)
    abort 'Имя вида должно быть символом!' unless view_name.instance_of? Symbol

    send view_name
  end

  private

  # главный экран
  def main_screen
    puts I18n.t('interface.header_possible_actions')

    generate_menu(
      1 => I18n.t('interface.button_trains_management'),
      2 => I18n.t('interface.button_stations_management'),
      3 => I18n.t('interface.button_carriages_management')
    )

    print_exit_button_and_prompt
  end

  # экран выбора действий с поездами
  def train_action_selection
    puts I18n.t('train.interface.header_trains_action_selection')

    generate_menu(
      1 => I18n.t('train.interface.button_create_new_train'),
      2 => I18n.t('train.interface.button_pick_existing_train')
    )

    print_back_button_and_prompt
  end

  # экран со списком всех существующих поездов
  def trains_list
    puts I18n.t('train.interface.header_choose_train')

    Train.each_created do |train|
      puts "#{train.number} -- #{train.type} (вагонов: #{train.carriages.size})"
    end

    print_back_button_and_prompt
  end

  # экран выбора действий со станцией
  def station_action_selection
    puts I18n.t('station.interface.header_actions_options')

    generate_menu(
      1 => I18n.t('station.interface.button_create_station'),
      2 => I18n.t('station.interface.button_stations_list'),
      3 => I18n.t('station.interface.button_station_trains_list')
    )

    print_back_button_and_prompt
  end

  # экран выбора типа создаваемого поезда
  def new_train_type_selection
    puts I18n.t('train.interface.header_what_train_type_to_create')

    generate_menu(
      1 => I18n.t('train.passenger.type'),
      2 => I18n.t('train.cargo.type')
    )

    print_back_button_and_prompt
  end

  # экран действий над поездом
  def train_actions_screen
    puts I18n.t('train.interface.header_you_choose_train', @@screen_vars)
    puts I18n.t('train.interface.header_action_selection')

    generate_menu(
      1 => I18n.t('train.interface.button_send_to_station')
    )

    print_back_button_and_prompt
  end

  # создание станции
  def station_creation_dialog
    puts I18n.t('station.interface.header_new_station')

    print_back_button_and_prompt
  end

  # создание поезда
  def new_train_creation_dialog
    puts I18n.t('train.interface.header_enter_new_train_number')

    print_back_button_and_prompt
  end

  # список станций
  def stations_list
    puts I18n.t('station.interface.header_following_stations_exists')

    stations.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список станций с возможность выбора куда отправить поезд
  def train_move_to_station_dialog
    puts I18n.t('train.interface.header_choose_station_for_train_to_send', @@screen_vars)

    stations.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список станций с возможностью выбора одной
  def stations_list_selection
    puts I18n.t('station.interface.header_choose_station_for_trains_list')

    stations.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список поездов на станции
  def trains_on_station_list
    station = @@screen_vars[:station]

    puts I18n.t('station.interface.header_trains_list', station_name: station.name)

    station.each_train do |train|
      puts "#{train.number} -- #{train.type} (вагонов: #{train.carriages.size})"
    end

    print_back_button_and_prompt
  end

  # список существующих поездов
  def existing_trains_selection
    puts I18n.t('train.interface.header_choose_train')

    Train.each_created do |train|
      puts "#{train.number} -- #{train.type} (вагонов: #{train.carriages.size})"
    end

    print_back_button_and_prompt
  end

  # управление вагонами
  def carriage_action_selection
    puts I18n.t('carriage.interface.header_carriage_action_selection')

    generate_menu(
      1 => I18n.t('carriage.interface.button_add_carriage'),
      2 => I18n.t('carriage.interface.button_remove_carriage'),
      3 => I18n.t('carriage.interface.button_show_train_carriages_list'),
      4 => I18n.t('carriage.interface.button_take_carriage_space')
    )

    print_back_button_and_prompt
  end

  # экран указания параметров создаваемого вагона
  def new_carriage_creation_dialog
    case @@screen_vars[:train_type]
    when Train::CargoTrain
      puts I18n.t('carriage.interface.header_new_cargo_carriage_creation_dialog')
    when Train::PassengerTrain
      puts I18n.t('carriage.interface.header_new_passenger_carriage_creation_dialog')
    end

    print_back_button_and_prompt
  end

  # список вагонов на выбор для занятия места
  def carriage_to_take_space_selection
    puts I18n.t('carriage.interface.header_carriages_to_take_space')

    Carriage.each_created do |carriage|
      case carriage
      when Carriage::CargoCarriage
        puts "#{carriage.number} -- #{carriage.type}. Свободно объёма: #{carriage.space_free} из #{carriage.total_space}"
      when Carriage::PassengerCarriage
        puts "#{carriage.number} -- #{carriage.type}. Свободных мест: #{carriage.seats_free} из #{carriage.total_seats}"
      end
    end

    print_back_button_and_prompt
  end

  # выбор поезда для прицепления вагона
  def train_to_add_carriage_selection
    puts I18n.t('carriage.interface.header_select_train_to_add_carriage')

    Train.each_created do |train|
      puts "#{train.number} -- #{train.type} (вагонов: #{train.carriages.size})"
    end

    print_back_button_and_prompt
  end

  # выбор поезда для отцепления вагона
  def train_to_remove_carriage_selection
    puts I18n.t('carriage.interface.header_select_train_to_remove_carriage')

    Train.each_created do |train|
      puts "#{train.number} -- #{train.type} (вагонов: #{train.carriages.size})"
    end

    print_back_button_and_prompt
  end

  # список существующих поездов
  def train_carriages_list
    puts I18n.t('carriage.interface.header_train_carriages_list')

    Train.each_created do |train|
      puts "#{train.number} -- #{train.type}"
    end

    print_back_button_and_prompt
  end

  # ввод объёма/места при создании вагона
  def carriage_space_value_input_dialog
    case @@screen_vars[:carriage]
    when Carriage::CargoCarriage
      puts I18n.t('carriage.interface.header_carriage_space_value_input_dialog_cargo')
    when Carriage::PassengerCarriage
      puts I18n.t('carriage.interface.header_carriage_space_value_input_dialog_passenger')
    end

    print_back_button_and_prompt
  end

  # список вагонов у поезда
  def carriages_in_train
    train = @@screen_vars[:train]

    puts I18n.t('train.interface.header_carriages_list', train_number: train.number)

    train.each_carriage do |carriage|
      case carriage
      when Carriage::CargoCarriage
        puts "#{carriage.number} (#{carriage.type}) -- свободно объёма #{carriage.space_free} из #{carriage.total_space}"
      when Carriage::PassengerCarriage
        puts "#{carriage.number} (#{carriage.type}) -- свободно места #{carriage.seats_free} из #{carriage.total_seats}"
      end
    end

    print_back_button_and_prompt
  end
end
