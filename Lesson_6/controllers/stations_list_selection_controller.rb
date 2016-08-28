class StationsListSelectionController < ApplicationController
  PARENT_SCREEN = :station_action_selection

  def run
    if stations.key? @@user_input
      station = stations[@@user_input]

      if station.trains_list.size > 0
        @@screen = :trains_on_station_list
        @@screen_vars = {station: station}
      else
        flash_error(I18n.t('station.interface.message_no_trains_on_this_station'))
      end
    else
      flash_error(I18n.t('station.interface.message_no_such_station'))
    end
  end
end