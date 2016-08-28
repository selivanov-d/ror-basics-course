class ExistingTrainsSelectionController < ApplicationController
  PARENT_SCREEN = :train_action_selection

  def run
    if Train.all.keys.include? @@user_input
      train = Train.all[@@user_input]

      @@screen = :train_actions_screen
      @@action_vars = {train: train}
      @@screen_vars = {train_number: train.number}
    else
      flash_error(I18n.t('train.interface.message_no_such_train'))
    end
  end
end