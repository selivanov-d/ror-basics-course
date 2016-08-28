class TrainActionsScreenController < ApplicationController
  PARENT_SCREEN = :existing_trains_selection

  def run
    train = @@action_vars[:train]

    case @@user_input
      when '1'
        case train
          when Train::CargoTrain
            carriage = Carriage::CargoCarriage.new
          when Train::PassengerTrain
            carriage = Carriage::PassengerCarriage.new
        end

        train.add_carriage(carriage)

        flash_message(I18n.t('train.interface.message_carriage_added'))

        @@screen_vars = {train_number: train.number}
      when '2'
        if train.carriages.size > 0
          train.remove_last_carriage
          flash_message(I18n.t('train.interface.message_last_carriage_removed'))
        else
          flash_message(I18n.t('train.interface.message_no_carriages_in_this_train'))
        end

        @@screen_vars = {train_number: train.number}
      when '3'
        if stations.size > 0
          @@screen = :train_move_to_station_dialog
        else
          flash_error(I18n.t('station.interface.message_no_stations_exists'))
        end

        @@screen_vars = {train_number: train.number}
      else
        flash_error
    end
  end
end