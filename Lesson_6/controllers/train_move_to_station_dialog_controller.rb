class TrainMoveToStationDialogController < ApplicationController
  PARENT_SCREEN = :train_actions_screen

  def run
    train = @@action_vars[:train]

    @@screen_vars = {train_number: train.number}
    @@action_vars = {train: train}

    if stations.key? @@user_input
      train.move_to_station(@@user_input)

      flash_message(I18n.t('train.interface.message_train_moved_to_station', station_name: @@user_input))

      @@screen = :train_actions_screen
    else
      flash_error(I18n.t('station.interface.message_no_such_station'))
    end
  end
end