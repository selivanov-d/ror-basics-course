class TrainToAddCarriageSelectionController < ApplicationController
  PARENT_SCREEN = :carriage_action_selection

  def run
    train = Train.find(@@user_input)

    if train.nil?
      flash_error(I18n.t('train.interface.message_no_such_train'))
    else
      @@action_vars = { train: train }
      @@screen_vars = { train: train }

      @@screen = :new_carriage_creation_dialog
    end
  end
end
