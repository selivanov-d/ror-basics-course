class StationCreationDialogController < ApplicationController
  PARENT_SCREEN = :station_action_selection

  def run
    if stations.key? @@user_input
      flash_error(I18n.t('station.interface.message_such_station_already_exists'))
    else
      station = Station.new(@@user_input)

      @@route.add_station(station)

      flash_message(I18n.t('station.interface.message_station_created', station_name: station.name))

      @@screen = :station_action_selection
    end
  end
end