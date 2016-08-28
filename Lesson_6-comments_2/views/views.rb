module Views
  include ViewsHelper

  @@screen_vars = {}

  def render(view_name)
    abort 'Имя вида должно быть символом!' unless view_name.instance_of? Symbol

    self.send view_name
  end

  private
  # главный экран
  def main_screen
    puts I18n.t('interface.header_possible_actions')

    generate_menu({
                      1 => I18n.t('interface.button_trains_management'),
                      2 => I18n.t('interface.button_stations_management')
                  })

    print_exit_button_and_prompt
  end

  # экран выбора действий с поездами
  def train_action_selection
    puts I18n.t('train.interface.header_trains_action_selection')

    generate_menu({
                      1 => I18n.t('train.interface.button_create_new_train'),
                      2 => I18n.t('train.interface.button_pick_existing_train')
                  })

    print_back_button_and_prompt
  end

  # экран со списком всех существующих поездов
  def trains_list
    puts I18n.t('train.interface.header_choose_train')

    Train.all.each_value do |train|
      puts train
    end

    print_back_button_and_prompt
  end

  # экран выбора действий со станцией
  def station_action_selection
    puts I18n.t('station.interface.header_actions_options')

    generate_menu({
                      1 => I18n.t('station.interface.button_create_station'),
                      2 => I18n.t('station.interface.button_stations_list'),
                      3 => I18n.t('station.interface.button_station_trains_list')
                  })

    print_back_button_and_prompt
  end

  # экран выбора типа создаваемого поезда
  def new_train_type_selection
    puts I18n.t('train.interface.header_what_train_type_to_create')

    generate_menu({
                      1 => I18n.t('train.passenger.type'),
                      2 => I18n.t('train.cargo.type')
                  })

    print_back_button_and_prompt
  end

  # экран действий над поездом
  def train_actions_screen
    puts I18n.t('train.interface.header_you_choose_train', @@screen_vars)
    puts I18n.t('train.interface.header_action_selection')

    generate_menu({
                      1 => I18n.t('train.interface.button_add_carriage'),
                      2 => I18n.t('train.interface.button_remove_carriage'),
                      3 => I18n.t('train.interface.button_send_to_station')
                  })

    print_back_button_and_prompt
  end

  # создание поезда
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

    station.trains_list.each_value do |train|
      puts train
    end

    print_back_button_and_prompt
  end

  # список существующих поездов
  def existing_trains_selection
    puts I18n.t('train.interface.header_choose_train')

    Train.all.each_value do |train|
      puts train
    end

    print_back_button_and_prompt
  end
end