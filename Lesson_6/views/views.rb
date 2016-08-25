module Views
  include ViewsHelper
  include TranslationHelper

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
    print_message({path: [:interface, :header_possible_actions]})

    generate_menu({
                      1 => get_message({path: [:interface, :button_trains_management]}),
                      2 => get_message({path: [:interface, :button_stations_management]})
                  })

    print_exit_button_and_prompt
  end

  # экран выбора действий с поездами
  def train_action_selection
    print_message({path: [:train, :interface, :header_trains_action_selection]})

    generate_menu({
                      1 => get_message({path: [:train, :interface, :button_create_new_train]}),
                      2 => get_message({path: [:train, :interface,:button_pick_existing_train]})
                  })

    print_back_button_and_prompt
  end

  def trains_list
    print_message({path: [:train, :interface, :header_choose_train]})

    @trains.each_value do |train|
      puts train
    end

    print_back_button_and_prompt
  end

  # экран выбора действий со станцией
  def station_action_selection
    print_message({path: [:station, :interface,:header_actions_options]})

    generate_menu({
                      1 => get_message({path: [:station, :interface, :button_create_station]}),
                      2 => get_message({path: [:station, :interface, :button_stations_list]}),
                      3 => get_message({path: [:station, :interface, :button_station_trains_list]})
                  })

    print_back_button_and_prompt
  end

  # экран выбора типа создаваемого поезда
  def new_train_type_selection
    print_message({path: [:train, :interface, :header_what_train_type_to_create]})

    generate_menu({
                      1 => get_message({path: [:train, :passenger, :type]}),
                      2 => get_message({path: [:train, :cargo, :type]})
                  })

    print_back_button_and_prompt
  end

  # экран действий над поездом
  def train_actions_screen(screen_vars)
    print_message({path: [:train, :interface, :header_you_choose_train]})
    print_message({path: [:train, :interface, :header_action_selection]})

    generate_menu({
                      1 => get_message({path: [:train, :interface, :button_add_carriage]}),
                      2 => get_message({path: [:train, :interface, :button_remove_carriage]}),
                      3 => get_message({path: [:train, :interface, :button_send_to_station]})
                  })

    print_back_button_and_prompt
  end

  # создание поезда
  def station_creation_dialog
    print_message({path: [:station, :interface, :header_new_station]})

    print_back_button_and_prompt
  end

  # создание поезда
  def new_train_creation_dialog
    print_message({path: [:train, :interface, :header_enter_new_train_number]})

    print_back_button_and_prompt
  end

  # список станций
  def stations_list
    print_message({path: [:station, :interface, :header_following_stations_exists]})

    stations.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список станций с возможность выбора куда отправить поезд
  def train_move_to_station_dialog
    print_message({path: [:train, :interface, :header_choose_station_for_train_to_send]})

    stations.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список станций с возможностью выбора одной
  def stations_list_selection
    print_message({path: [:station, :interface, :header_choose_station_for_trains_list]})

    stations.each_value do |station|
      puts station
    end

    print_back_button_and_prompt
  end

  # список поездов на станции
  def trains_on_station_list(screen_vars)
    station = screen_vars[:station]

    print_message({path: [:station, :interface, :header_trains_list]})

    station.trains_list.each_value do |train|
      puts train
    end

    print_back_button_and_prompt
  end

  def existing_trains_selection
    print_message({path: [:train, :interface, :header_choose_train]})

    @trains.each_value do |train|
      puts train
    end

    print_back_button_and_prompt
  end
end