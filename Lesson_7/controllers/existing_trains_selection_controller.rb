class ExistingTrainsSelectionController < ApplicationController
  PARENT_SCREEN = :train_action_selection

  def run
    train = Train.find @@user_input

    if train
      @@screen = :train_actions_screen
      @@action_vars = { train: train }
      @@screen_vars = { train_number: train.number }
    else
      flash_error(I18n.t('train.interface.message_no_such_train'))
    end
  end
end
