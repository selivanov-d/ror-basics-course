module ViewsController
  include ViewsControllerHelper

  def render(view_name, view_vars = {})
    raise 'Имя вида должно быть символом!' unless view_name.instance_of? Symbol

    if view_vars.empty?
      self.send view_name
    else
      self.send view_name, view_vars
    end
  end

  private
  # главный экран программы
  def main_screen
    I18n.t(:header_possible_actions, scope: [:interface])

    generate_menu({1 => I18n.t(:button_trains_management, scope: [:interface]), 2 => I18n.t(:button_stations_management, scope: [:interface])})

    print_exit_button_and_prompt
  end

  # экран выбора действий с поездами
  def train_action_selection
    print_message(:header_trains_action_selection, [:train, :interface])

    generate_menu({1 => I18n.t(:button_create_new_train, scope: [:train, :interface]), 2 => I18n.t(:button_pick_existing_train, scope: [:train, :interface])})

    print_back_button_and_prompt
  end

  def trains_list
    print_message(:header_choose_train, [:train, :interface])

    @trains.each_value do |train|
      puts train
    end

    print_back_button_and_prompt
  end

  # экран выбора действий со станцией
  def station_action_selection
    print_message(:header_actions_options, scope: [:station, :interface])

    generate_menu({1 => I18n.t(:button_create_station, scope: [:station, :interface]), 2 => I18n.t(:button_stations_list, scope: [:station, :interface]), 3 => I18n.t(:button_station_trains_list, scope: [:station, :interface])})

    print_back_button_and_prompt
  end

  # экран выбора типа создаваемого поезда
  def new_train_type_selection
    print_message(:header_what_train_type_to_create, [:train, :interface])

    generate_menu({1 => I18n.t(:type, scope: [:train, :passenger]), 2 => I18n.t(:type, scope: [:train, :cargo])})

    print_back_button_and_prompt
  end

  # экран действий над поездом
  def train_actions_screen
    print_message(:header_you_choose_train, [:train, :interface]) #,  {train_name: train.number})
    print_message(:header_action_selection, [:train, :interface])

    generate_menu({1 => I18n.t(:button_add_carriage, scope: [:train, :interface]), 2 => I18n.t(:button_remove_carriage, scope: [:train, :interface]), 3 => I18n.t(:button_send_to_station, scope: [:train, :interface])})

    print_back_button_and_prompt
  end

  # создание поезда
  def station_creation_dialog
    print_message(:header_new_station, [:station, :interface])

    print_back_button_and_prompt
  end

  # создание поезда
  def new_train_creation_dialog
    print_message(:header_enter_new_train_number, [:train,  :interface])

    print_back_button_and_prompt
  end

  # список станций
  def stations_list
    print_message(:header_following_stations_exists, [:station, :interface])

    @route.stations_list.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список станций с возможность выбора куда отправить поезд
  def train_move_to_station_dialog
    print_message(:header_choose_station_for_train_to_send, [:train, :interface])

    stations.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список станций с возможностью выбора одной
  def stations_list_selection
    print_message(:header_choose_station_for_trains_list, [:station, :interface])

    @stations.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список поездов на станции
  def trains_on_station_list
    print_message(:header_trains_list, [:station, :interface])

    @station.trains_list.each_value do |train|
      puts train
    end

    print_back_button_and_prompt
  end
end