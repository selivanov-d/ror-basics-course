class StationActionSelectionController < ApplicationController
  PARENT_SCREEN = :main_screen

  def run
    case @@user_input
      when '1'
        @@screen = :station_creation_dialog
      when '2'
        if stations.size > 0
          @@screen = :stations_list
        else
          flash_error(I18n.t('station.interface.message_no_stations_exists'))
        end

      when '3'
        if stations.size > 0
          @@screen = :stations_list_selection
        else
          flash_error(I18n.t('station.interface.message_no_stations_exists'))
        end
      else
        flash_error
    end
  end
end