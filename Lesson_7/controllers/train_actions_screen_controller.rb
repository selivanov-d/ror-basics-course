class TrainActionsScreenController < ApplicationController
  PARENT_SCREEN = :existing_trains_selection

  def run
    train = @@action_vars[:train]

    case @@user_input
    when '1'
      if !stations.empty?
        @@screen = :train_move_to_station_dialog
      else
        flash_error(I18n.t('station.interface.message_no_stations_exists'))
      end

      @@screen_vars = { train_number: train.number }
    else
      flash_error
    end
  end
end
