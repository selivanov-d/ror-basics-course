class TrainsOnStationListController < ApplicationController
  PARENT_SCREEN = :stations_list_selection

  def run
    if !stations.empty?
      @@screen = :stations_list_selection

      if stations.key? @@user_input
        station = stations[@@user_input]

        if !station.trains_list.empty?
          @@screen = :trains_on_station_list
        else
          flash_error(I18n.t('station.interface.message_no_trains_on_this_station'))
        end
      else
        flash_error(I18n.t('station.interface.message_no_such_station'))
      end
    else
      flash_error(I18n.t('station.interface.message_no_stations_exists'))

      @@screen = :station_action_selection
    end
  end
end
