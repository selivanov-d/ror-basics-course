class TrainToRemoveCarriageSelectionController < ApplicationController
  PARENT_SCREEN = :carriage_action_selection

  def run
    if Train.find @@user_input
      Train.find(@@user_input).remove_last_carriage
      flash_message(I18n.t('train.interface.message_last_carriage_removed'))
    else
      flash_error(I18n.t('train.interface.message_no_such_train'))
    end
  end
end
